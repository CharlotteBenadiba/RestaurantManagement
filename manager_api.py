import psycopg2
import menu
import time


class ManagerChoices:
    conn = psycopg2.connect(
        database="RestaurantManagement",
        user="postgres",
        password="New2020Road!",
        host="localhost",
        port="5433",
    )

    conn.autocommit = True
    cursor = conn.cursor()

    @classmethod
    def search_to(cls):
        query = """
        SELECT COUNT(order_id), SUM(total_price) FROM Orders
        """
        cls.cursor.execute(query)
        results = cls.cursor.fetchall()
        for row in results:
            print(f"Total number of orders: {row[0]} with a total of ${row[1]}\n")
        time.sleep(0.2)
        menu.manager()

    @classmethod
    def search_ao(cls):
        query = """
        SELECT COUNT(order_id), SUM(total_price) FROM Orders WHERE order_delivered = FALSE
        """
        cls.cursor.execute(query)
        results = cls.cursor.fetchall()
        for row in results:
            print(
                f"Total number of active orders: {row[0]} with a total of £{row[1]}\n"
            )
        time.sleep(0.2)
        menu.manager()

    @classmethod
    def search_co(cls):
        # searches db table orders for a count of all cancelled orders (orders that have cancelled as TRUE)
        query = """
        SELECT COUNT(order_id), SUM(total_price) FROM Orders WHERE cancelled = TRUE
        """
        cls.cursor.execute(query)
        results = cls.cursor.fetchall()
        for row in results:
            print(
                f"The total number of cancelled orders is: {row[0]} with a total lost value of £{row[1]}\n"
            )
        time.sleep(0.2)
        menu.manager()

    @classmethod
    def search_bw(cls):
        # searches db table orders for the count of all waiters and returns 1 row with the count in desc order
        query = """
        SELECT CONCAT(wa.first_name, ' ', wa.last_name) AS full_name, COUNT(ord.waiter_id) AS total_orders
        FROM Orders AS ord 
        JOIN Waiters AS wa ON ord.waiter_id = wa.waiter_id
        GROUP BY full_name
        ORDER BY total_orders DESC
        LIMIT 1
        """
        cls.cursor.execute(query)
        result = cls.cursor.fetchone()
        if result:
            full_name, total_orders = result
            print(
                f"The waiter with the highest number of sales is: {full_name} with {total_orders} orders\n"
            )
        time.sleep(0.2)
        menu.manager()

    @classmethod
    def search_bc(cls):
        # searches db table orders for the count of all customers and returns 1 row with the count in desc order
        query = """
        SELECT CONCAT(cu.first_name, ' ', cu.last_name) AS full_name, COUNT(ord.customer_id) AS total_orders
        FROM Orders AS ord 
        JOIN Customers AS cu ON ord.customer_id = cu.customer_id
        GROUP BY full_name
        ORDER BY total_orders DESC
        LIMIT 1
        """
        cls.cursor.execute(query)
        result = cls.cursor.fetchone()
        if result:
            full_name, total_orders = result
            print(
                f"The customer with the highest number of orders is: {full_name} with {total_orders} orders\n"
            )
        time.sleep(0.2)
        menu.manager()

    def close_connection(cls):
        cls.conn.close()
