class OrdersController < ApplicationController

    def new
        @order  = Order.new
        @orders = Order.all()
    end

    def create
        order = calc_bojos()

        respond_to  do |format|
            if order.save
                format.html { redirect_to new_orders_path }
            else
                format.html { redirect_to new_orders_path }
            end
        end
    end

    def calc_bojos()
        order           = Order.new order_params
        order.loss      = order.amount * 1.1
        order.plates    = (order.loss.to_f / 8).ceil
        order.fabric    = (order.plates * 0.4).round(2)
        order.foam      = (order.plates * 1.2).round(2)
        order.total     = order.plates * 8

        return order
    end

    def sendproduction()
        num_orders = params["orders"].split(",")
        # Get Stock
        stock = Stock.all.reverse[0]
        # Get orders
        orders = Order.where(num_order: num_orders)

        go_production(stock, orders)

        take_stock(stock)

        respond_to do |format|
            format.html { redirect_to new_orders_path }
        end
    end

    def take_stock(stock)
        orders     = Order.where(is_factured: 1)
        total_foam = 0

        orders.each do |order|
            if order.color == "VERMELHO"
                stock.red_fabric -= order.fabric
                total_foam       += order.foam
            elsif order.color == "BRANCO"
                stock.white_fabric -= order.fabric
                total_foam         += order.foam
            elsif order.color == "PRETO"
                stock.black_fabric -= order.fabric
                total_foam         += order.foam
            end
        end
        stock.foam -= total_foam
        stock.save()
    end

    def go_production(stock, orders)
        products = nil
        values   = [["VERMELHO", stock.red_fabric],
            ["BRANCO", stock.white_fabric], ["PRETO", stock.black_fabric]]

        values.each do |value|
            products = orders.where(color: value[0], is_factured: 2)

            num_order = check_product(value[1], products)

            if num_order == 0
                check_go_production(value[1], products)
            else
                not_factured(orders, num_order)
            end
        end

        set_not_production()
        set_production()
    end

    def set_production()
        orders = Order.where(is_factured: 2)

        orders.each do |order|
            order.is_factured = 1
            order.save()
        end
    end

    def set_not_production()
        result = Order.where(is_factured: 0)
        if result.count > 0
            orders = Order.where(num_order: result[0].num_order, is_factured: 2)

            orders.each do |order|
                order.is_factured = 0
                order.save()
            end
        end
    end

    # Check if there is stock for products of orders
    def check_product(fabric, products)
        products.each do |product|
            if product.fabric > fabric
                return product.num_order
            end
        end
        return 0
    end

    def check_go_production(fabric, orders)
        unless orders.pluck("fabric").sum() <= fabric
            orders = removing_lowest_order(orders)
            check_go_production(fabric, orders)
        end
    end

    def removing_lowest_order(orders)
        num_order = 0
        values    = []
        order     = orders.pluck("num_order", "fabric")

        order.each do |o|
            values.push(o[1])
        end

        num_order = order[values.index(values.min)][0]
        results   = orders.where.not(num_order: num_order)
        not_factured(orders, num_order)

        return results
    end

    def not_factured(orders, num_order)
        results = orders.where(num_order: num_order)
        results.each do |result|
            result.is_factured = 0
            result.save()
        end
    end

    def check_foam(foam, orders)
        orders.pluck("foam").sum().round(2) >= foam
    end

    def order_params
        params.require(:order).permit :num_order, :customer, :color, :amount
    end
end