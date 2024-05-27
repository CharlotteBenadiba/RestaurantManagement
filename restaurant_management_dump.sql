toc.dat                                                                                             0000600 0004000 0002000 00000021735 14625004154 0014450 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP                       |           RestaurantManagement    16.3    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    17004    RestaurantManagement    DATABASE     �   CREATE DATABASE "RestaurantManagement" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United Kingdom.1252';
 &   DROP DATABASE "RestaurantManagement";
                postgres    false         �            1255    17105    calculate_total_price()    FUNCTION     X  CREATE FUNCTION public.calculate_total_price() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;
 .   DROP FUNCTION public.calculate_total_price();
       public          postgres    false         �            1259    17005    customer_id_seq    SEQUENCE     z   CREATE SEQUENCE public.customer_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.customer_id_seq;
       public          postgres    false         �            1259    17006 	   customers    TABLE     �  CREATE TABLE public.customers (
    customer_id text DEFAULT ('C'::text || nextval('public.customer_id_seq'::regclass)) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number bigint NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.customers;
       public         heap    postgres    false    215         �            1259    17081    menu_id_seq    SEQUENCE     v   CREATE SEQUENCE public.menu_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.menu_id_seq;
       public          postgres    false         �            1259    17082    menu    TABLE     �  CREATE TABLE public.menu (
    item_id text DEFAULT ('M'::text || nextval('public.menu_id_seq'::regclass)) NOT NULL,
    item_name character varying(100) NOT NULL,
    category character varying(100) NOT NULL,
    price integer NOT NULL,
    available boolean DEFAULT true,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted timestamp without time zone
);
    DROP TABLE public.menu;
       public         heap    postgres    false    221         �            1259    17043    order_id_seq    SEQUENCE     w   CREATE SEQUENCE public.order_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.order_id_seq;
       public          postgres    false         �            1259    17044    orders    TABLE     h  CREATE TABLE public.orders (
    order_id text DEFAULT ('OR'::text || nextval('public.order_id_seq'::regclass)) NOT NULL,
    customer_id text NOT NULL,
    waiter_id text NOT NULL,
    items jsonb NOT NULL,
    total_price numeric,
    food_unavailable boolean DEFAULT false,
    prepare_order boolean DEFAULT false,
    order_ready boolean DEFAULT false,
    order_delivered boolean DEFAULT false,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cancelled boolean DEFAULT false,
    order_complete boolean DEFAULT false
);
    DROP TABLE public.orders;
       public         heap    postgres    false    219         �            1259    17016    waiter_id_seq    SEQUENCE     x   CREATE SEQUENCE public.waiter_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.waiter_id_seq;
       public          postgres    false         �            1259    17017    waiters    TABLE     d  CREATE TABLE public.waiters (
    waiter_id text DEFAULT ('W'::text || nextval('public.waiter_id_seq'::regclass)) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.waiters;
       public         heap    postgres    false    217         �          0    17006 	   customers 
   TABLE DATA           o   COPY public.customers (customer_id, first_name, last_name, email, phone_number, created, modified) FROM stdin;
    public          postgres    false    216       4824.dat �          0    17082    menu 
   TABLE DATA           j   COPY public.menu (item_id, item_name, category, price, available, created, modified, deleted) FROM stdin;
    public          postgres    false    222       4830.dat �          0    17044    orders 
   TABLE DATA           �   COPY public.orders (order_id, customer_id, waiter_id, items, total_price, food_unavailable, prepare_order, order_ready, order_delivered, created, modified, cancelled, order_complete) FROM stdin;
    public          postgres    false    220       4828.dat �          0    17017    waiters 
   TABLE DATA           V   COPY public.waiters (waiter_id, first_name, last_name, created, modified) FROM stdin;
    public          postgres    false    218       4826.dat �           0    0    customer_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.customer_id_seq', 170, true);
          public          postgres    false    215         �           0    0    menu_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.menu_id_seq', 175, true);
          public          postgres    false    221         �           0    0    order_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.order_id_seq', 109, true);
          public          postgres    false    219         �           0    0    waiter_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.waiter_id_seq', 120, true);
          public          postgres    false    217         >           2606    17015    customers customer_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);
 A   ALTER TABLE ONLY public.customers DROP CONSTRAINT customer_pkey;
       public            postgres    false    216         D           2606    17092    menu menu_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (item_id);
 8   ALTER TABLE ONLY public.menu DROP CONSTRAINT menu_pkey;
       public            postgres    false    222         B           2606    17058    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    220         @           2606    17026    waiters waiters_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.waiters
    ADD CONSTRAINT waiters_pkey PRIMARY KEY (waiter_id);
 >   ALTER TABLE ONLY public.waiters DROP CONSTRAINT waiters_pkey;
       public            postgres    false    218         G           2620    17106    orders set_total_price    TRIGGER     �   CREATE TRIGGER set_total_price BEFORE INSERT OR UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.calculate_total_price();
 /   DROP TRIGGER set_total_price ON public.orders;
       public          postgres    false    223    220         E           2606    17059    orders fk_customer    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk_customer;
       public          postgres    false    4670    216    220         F           2606    17064    orders fk_waiter    FK CONSTRAINT     z   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_waiter FOREIGN KEY (waiter_id) REFERENCES public.waiters(waiter_id);
 :   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk_waiter;
       public          postgres    false    218    220    4672                                           4824.dat                                                                                            0000600 0004000 0002000 00000016771 14625004154 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        C101	Emma	Wilson	emma.wilson@example.com	5551234567	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C102	Liam	Johnson	liam.johnson@example.com	5552345678	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C103	Olivia	Brown	olivia.brown@example.com	5553456789	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C104	Noah	Davis	noah.davis@example.com	5554567890	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C105	Ava	Miller	ava.miller@example.com	5555678901	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C106	Ethan	Martinez	ethan.martinez@example.com	5556789012	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C107	Sophia	Hernandez	sophia.hernandez@example.com	5557890123	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C108	Lucas	Garcia	lucas.garcia@example.com	5558901234	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C109	Mia	Rodriguez	mia.rodriguez@example.com	5559012345	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C110	Mason	Lee	mason.lee@example.com	5550123456	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C111	Isabella	Anderson	isabella.anderson@example.com	5551234568	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C112	Logan	Thomas	logan.thomas@example.com	5552345679	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C113	Amelia	Moore	amelia.moore@example.com	5553456780	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C114	James	Jackson	james.jackson@example.com	5554567891	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C115	Charlotte	White	charlotte.white@example.com	5555678902	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C116	Benjamin	Harris	benjamin.harris@example.com	5556789013	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C117	Harper	Martin	harper.martin@example.com	5557890124	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C118	Alexander	Thompson	alexander.thompson@example.com	5558901235	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C119	Evelyn	Robinson	evelyn.robinson@example.com	5559012346	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C120	Ella	Clark	ella.clark@example.com	5550123457	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C121	William	Walker	william.walker@example.com	5551234566	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C122	Sofia	Lewis	sofia.lewis@example.com	5552345675	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C123	Michael	Hill	michael.hill@example.com	5553456784	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C124	Emma	Green	emma.green@example.com	5554567893	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C125	James	Hall	james.hall@example.com	5555678902	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C126	Sophia	Young	sophia.young@example.com	5556789011	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C127	Daniel	Allen	daniel.allen@example.com	5557890120	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C128	Madison	King	madison.king@example.com	5558901239	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C129	Jacob	Wright	jacob.wright@example.com	5559012348	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C130	Olivia	Lopez	olivia.lopez@example.com	5550123457	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C131	William	Scott	william.scott@example.com	5551234566	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C132	Emily	Adams	emily.adams@example.com	5552345675	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C133	David	Baker	david.baker@example.com	5553456784	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C134	Emma	Gonzalez	emma.gonzalez@example.com	5554567893	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C135	Olivia	Nelson	olivia.nelson@example.com	5555678902	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C136	William	Carter	william.carter@example.com	5556789011	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C137	Sophia	Hill	sophia.hill@example.com	5557890120	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C138	Daniel	Mitchell	daniel.mitchell@example.com	5558901239	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C139	Isabella	Roberts	isabella.roberts@example.com	5559012348	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C140	Mia	Turner	mia.turner@example.com	5550123457	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C141	Alexander	Phillips	alexander.phillips@example.com	5551234566	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C142	Ethan	Campbell	ethan.campbell@example.com	5552345675	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C143	Amelia	Parker	amelia.parker@example.com	5553456784	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C144	Mason	Evans	mason.evans@example.com	5554567893	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C145	Charlotte	Edwards	charlotte.edwards@example.com	5555678902	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C146	Ella	Collins	ella.collins@example.com	5556789011	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C147	James	Stewart	james.stewart@example.com	5557890120	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C148	Isabella	Morris	isabella.morris@example.com	5558901239	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C149	Michael	Nguyen	michael.nguyen@example.com	5559012348	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C150	Evelyn	Nguyen	evelyn.nguyen@example.com	5550123457	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C151	Ethan	Nguyen	ethan.nguyen@example.com	5551234566	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C152	Sophia	Nguyen	sophia.nguyen@example.com	5552345675	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C153	Lucas	Nguyen	lucas.nguyen@example.com	5553456784	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C154	Olivia	Nguyen	olivia.nguyen@example.com	5554567893	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C155	Emma	Nguyen	emma.nguyen@example.com	5555678902	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C156	Ava	Nguyen	ava.nguyen@example.com	5556789011	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C157	Logan	Nguyen	logan.nguyen@example.com	5557890120	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C158	Mia	Nguyen	mia.nguyen@example.com	5558901239	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C159	James	Nguyen	james.nguyen@example.com	5559012348	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C160	William	Nguyen	william.nguyen@example.com	5550123457	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C161	Charlotte	Nguyen	charlotte.nguyen@example.com	5551234566	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C162	Benjamin	Nguyen	benjamin.nguyen@example.com	5552345675	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C163	Harper	Nguyen	harper.nguyen@example.com	5553456784	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C164	Mason	Nguyen	mason.nguyen@example.com	5554567893	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C165	Ella	Nguyen	ella.nguyen@example.com	5555678902	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C166	Amelia	Nguyen	amelia.nguyen@example.com	5556789011	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C167	Oliver	Nguyen	oliver.nguyen@example.com	5557890120	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C168	Jacob	Nguyen	jacob.nguyen@example.com	5558901239	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C169	Daniel	Nguyen	daniel.nguyen@example.com	5559012348	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
C170	William	Nguyen	william.nguyen@example.com	5559012523	2024-05-26 19:57:40.274156	2024-05-26 19:57:40.274156
\.


       4830.dat                                                                                            0000600 0004000 0002000 00000014557 14625004154 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        M102	Bruschetta	Starters	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M103	Stuffed Mushrooms	Starters	8	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M104	Caesar Salad	Starters	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M105	Tomato Basil Soup	Starters	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M106	Mozzarella Sticks	Starters	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M107	Chicken Wings	Starters	9	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M108	Spinach Artichoke Dip	Starters	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M109	Shrimp Cocktail	Starters	10	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M110	Caprese Salad	Starters	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M111	French Onion Soup	Starters	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M112	Deviled Eggs	Starters	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M113	Calamari	Starters	9	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M114	Meatballs	Starters	8	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M115	Cheese Platter	Starters	9	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M116	Grilled Salmon	Mains	16	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M117	Ribeye Steak	Mains	20	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M118	Chicken Alfredo	Mains	14	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M119	Veggie Burger	Mains	12	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M120	Spaghetti Bolognese	Mains	14	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M121	BBQ Ribs	Mains	17	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M122	Margherita Pizza	Mains	12	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M123	Beef Tacos	Mains	13	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M124	Shrimp Scampi	Mains	15	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M125	Lamb Chops	Mains	19	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M126	Chicken Parmesan	Mains	15	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M127	Vegan Stir Fry	Mains	13	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M128	Lobster Tail	Mains	25	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M129	Pork Chops	Mains	16	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M130	Turkey Sandwich	Mains	11	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M131	French Fries	Sides	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M132	Mashed Potatoes	Sides	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M133	Steamed Broccoli	Sides	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M134	Coleslaw	Sides	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M135	Onion Rings	Sides	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M136	Garden Salad	Sides	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M137	Baked Beans	Sides	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M138	Rice Pilaf	Sides	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M139	Grilled Asparagus	Sides	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M140	Mac and Cheese	Sides	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M141	Sweet Potato Fries	Sides	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M142	Corn on the Cob	Sides	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M143	Garlic Mashed Potatoes	Sides	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M144	Sautéed Spinach	Sides	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M145	Hush Puppies	Sides	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M146	Chocolate Cake	Desserts	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M147	Cheesecake	Desserts	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M148	Apple Pie	Desserts	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M149	Tiramisu	Desserts	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M150	Ice Cream Sundae	Desserts	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M151	Creme Brulee	Desserts	8	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M152	Brownie	Desserts	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M153	Panna Cotta	Desserts	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M154	Fruit Salad	Desserts	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M155	Lemon Tart	Desserts	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M156	Eclair	Desserts	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M157	Red Velvet Cake	Desserts	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M158	Key Lime Pie	Desserts	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M159	Profiteroles	Desserts	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M160	Banana Split	Desserts	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M161	Lemonade	Drinks	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M162	Iced Tea	Drinks	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M163	Cola	Drinks	2	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M164	Orange Juice	Drinks	3	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M165	Espresso	Drinks	2	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M166	Cappuccino	Drinks	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M167	Milkshake	Drinks	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M168	Smoothie	Drinks	4	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M169	Sparkling Water	Drinks	2	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M170	Red Wine	Drinks	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M171	White Wine	Drinks	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M172	Craft Beer	Drinks	5	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M173	Margarita	Drinks	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M174	Martini	Drinks	7	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M175	Mojito	Drinks	6	t	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
M101	Garlic Bread	Starters	6	f	2024-05-26 19:51:00.422891	2024-05-26 19:51:00.422891	\N
\.


                                                                                                                                                 4828.dat                                                                                            0000600 0004000 0002000 00000001265 14625004154 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        OR109	C136	W115	[{"price": 7, "item_id": "M106", "category": "Starters", "item_name": "Mozzarella Sticks"}, {"price": 23, "item_id": "M122", "category": "Mains", "item_name": "Margherita Pizza"}, {"price": 6, "item_id": "M171", "category": "Drinks", "item_name": "White Wine"}]	36	f	t	t	f	2024-05-26 22:27:34.008688	2024-05-26 22:27:34.008688	f	t
OR108	C101	W105	[{"price": 8, "item_id": "M103", "category": "Starters", "item_name": "Stuffed Mushrooms"}, {"price": 25, "item_id": "M128", "category": "Mains", "item_name": "Lobster Tail"}, {"price": 5, "item_id": "M172", "category": "Drinks", "item_name": "Craft Beer"}]	38	f	t	t	t	2024-05-26 21:23:58.11929	2024-05-26 21:23:58.11929	t	f
\.


                                                                                                                                                                                                                                                                                                                                           4826.dat                                                                                            0000600 0004000 0002000 00000002612 14625004154 0014257 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        W101	John	Smith	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W102	Emma	Johnson	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W103	Liam	Williams	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W104	Olivia	Brown	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W105	Noah	Jones	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W106	Ava	Garcia	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W107	Ethan	Martinez	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W108	Sophia	Rodriguez	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W109	Lucas	Davis	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W110	Mia	Lopez	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W111	Mason	Wilson	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W112	Isabella	Anderson	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W113	Logan	Thomas	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W114	Amelia	Hernandez	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W115	James	Moore	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W116	Charlotte	Martin	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W117	Benjamin	Lee	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W118	Harper	Perez	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W119	Alexander	White	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
W120	Evelyn	Harris	2024-05-26 19:53:07.91247	2024-05-26 19:53:07.91247
\.


                                                                                                                      restore.sql                                                                                         0000600 0004000 0002000 00000020655 14625004154 0015375 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE "RestaurantManagement";
--
-- Name: RestaurantManagement; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "RestaurantManagement" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United Kingdom.1252';


ALTER DATABASE "RestaurantManagement" OWNER TO postgres;

\connect "RestaurantManagement"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: calculate_total_price(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_total_price() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
$$;


ALTER FUNCTION public.calculate_total_price() OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id text DEFAULT ('C'::text || nextval('public.customer_id_seq'::regclass)) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number bigint NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.menu_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_id_seq OWNER TO postgres;

--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    item_id text DEFAULT ('M'::text || nextval('public.menu_id_seq'::regclass)) NOT NULL,
    item_name character varying(100) NOT NULL,
    category character varying(100) NOT NULL,
    price integer NOT NULL,
    available boolean DEFAULT true,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted timestamp without time zone
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_id_seq OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id text DEFAULT ('OR'::text || nextval('public.order_id_seq'::regclass)) NOT NULL,
    customer_id text NOT NULL,
    waiter_id text NOT NULL,
    items jsonb NOT NULL,
    total_price numeric,
    food_unavailable boolean DEFAULT false,
    prepare_order boolean DEFAULT false,
    order_ready boolean DEFAULT false,
    order_delivered boolean DEFAULT false,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cancelled boolean DEFAULT false,
    order_complete boolean DEFAULT false
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: waiter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.waiter_id_seq
    START WITH 101
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.waiter_id_seq OWNER TO postgres;

--
-- Name: waiters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.waiters (
    waiter_id text DEFAULT ('W'::text || nextval('public.waiter_id_seq'::regclass)) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    modified timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.waiters OWNER TO postgres;

--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, first_name, last_name, email, phone_number, created, modified) FROM stdin;
\.
COPY public.customers (customer_id, first_name, last_name, email, phone_number, created, modified) FROM '$$PATH$$/4824.dat';

--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (item_id, item_name, category, price, available, created, modified, deleted) FROM stdin;
\.
COPY public.menu (item_id, item_name, category, price, available, created, modified, deleted) FROM '$$PATH$$/4830.dat';

--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_id, waiter_id, items, total_price, food_unavailable, prepare_order, order_ready, order_delivered, created, modified, cancelled, order_complete) FROM stdin;
\.
COPY public.orders (order_id, customer_id, waiter_id, items, total_price, food_unavailable, prepare_order, order_ready, order_delivered, created, modified, cancelled, order_complete) FROM '$$PATH$$/4828.dat';

--
-- Data for Name: waiters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.waiters (waiter_id, first_name, last_name, created, modified) FROM stdin;
\.
COPY public.waiters (waiter_id, first_name, last_name, created, modified) FROM '$$PATH$$/4826.dat';

--
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_id_seq', 170, true);


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.menu_id_seq', 175, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_seq', 109, true);


--
-- Name: waiter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.waiter_id_seq', 120, true);


--
-- Name: customers customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: waiters waiters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.waiters
    ADD CONSTRAINT waiters_pkey PRIMARY KEY (waiter_id);


--
-- Name: orders set_total_price; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_total_price BEFORE INSERT OR UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.calculate_total_price();


--
-- Name: orders fk_customer; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- Name: orders fk_waiter; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_waiter FOREIGN KEY (waiter_id) REFERENCES public.waiters(waiter_id);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   