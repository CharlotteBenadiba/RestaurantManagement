CREATE OR REPLACE FUNCTION calculate_total_price()
RETURNS TRIGGER AS $$
DECLARE
    item JSONB;
    total NUMERIC := 0;
BEGIN
    FOR item IN SELECT * FROM jsonb_array_elements(NEW.items::jsonb) LOOP
        total := total + (item->>'price')::NUMERIC;
    END LOOP;

    NEW.total_price := total;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE TRIGGER set_total_price
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION calculate_total_price();



INSERT INTO orders (customer_id, waiter_id, items, prepare_order, order_ready, order_delivered) VALUES
('C101', 'W105', '[{"item_id": "M103", "item_name": "Stuffed Mushrooms", "category": "Starters", "price": 8}, {"item_id": "M128", "item_name": "Lobster Tail", "category": "Mains", "price": 25}, {"item_id": "M172", "item_name": "Craft Beer", "category": "Drinks", "price": 5}]', TRUE, TRUE, TRUE);

