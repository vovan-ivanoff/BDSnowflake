-- ============================================
-- LOAD DIMENSION: Store
-- ============================================
INSERT INTO dim_store (
    name,
    location,
    city,
    state,
    country,
    phone,
    email
)
SELECT DISTINCT
    store_name,
    store_location,
    store_city,
    store_state,
    store_country,
    store_phone,
    store_email
FROM mock_data;

-- ============================================
-- LOAD DIMENSION: Supplier
-- ============================================
INSERT INTO dim_supplier (
    name,
    contact,
    email,
    phone,
    address,
    city,
    country
)
SELECT DISTINCT
    supplier_name,
    supplier_contact,
    supplier_email,
    supplier_phone,
    supplier_address,
    supplier_city,
    supplier_country
FROM mock_data;

-- ============================================
-- LOAD DIMENSION: Customer
-- ============================================
INSERT INTO dim_customer (
    first_name,
    last_name,
    age,
    email,
    country,
    postal_code,
    pet_type,
    pet_name,
    pet_breed
)
SELECT DISTINCT
    customer_first_name,
    customer_last_name,
    customer_age,
    customer_email,
    customer_country,
    customer_postal_code,
    customer_pet_type,
    customer_pet_name,
    customer_pet_breed
FROM mock_data;

-- ============================================
-- LOAD DIMENSION: Seller
-- ============================================
INSERT INTO dim_seller (
    first_name,
    last_name,
    email,
    country,
    postal_code
)
SELECT DISTINCT
    seller_first_name,
    seller_last_name,
    seller_email,
    seller_country,
    seller_postal_code
FROM mock_data;

-- ============================================
-- LOAD DIMENSION: Product
-- ============================================
INSERT INTO dim_product (
    product_name,
    product_category,
    product_price,
    product_quantity,
    pet_category,
    product_weight,
    product_color,
    product_size,
    product_brand,
    product_material,
    product_description,
    product_rating,
    product_reviews,
    product_release_date,
    product_expiry_date,
    store_id,
    supplier_id
)
SELECT DISTINCT
    m.product_name,
    m.product_category,
    m.product_price,
    m.product_quantity,
    m.pet_category,
    m.product_weight,
    m.product_color,
    m.product_size,
    m.product_brand,
    m.product_material,
    m.product_description,
    m.product_rating,
    m.product_reviews,
    m.product_release_date,
    m.product_expiry_date,
    st.id AS store_id,
    sp.id AS supplier_id
FROM mock_data m
JOIN dim_store st
    ON st.name      IS NOT DISTINCT FROM m.store_name
   AND st.location  IS NOT DISTINCT FROM m.store_location
   AND st.city      IS NOT DISTINCT FROM m.store_city
   AND st.state     IS NOT DISTINCT FROM m.store_state
   AND st.country   IS NOT DISTINCT FROM m.store_country
   AND st.phone     IS NOT DISTINCT FROM m.store_phone
   AND st.email     IS NOT DISTINCT FROM m.store_email
JOIN dim_supplier sp
    ON sp.name      IS NOT DISTINCT FROM m.supplier_name
   AND sp.contact   IS NOT DISTINCT FROM m.supplier_contact
   AND sp.email     IS NOT DISTINCT FROM m.supplier_email
   AND sp.phone     IS NOT DISTINCT FROM m.supplier_phone
   AND sp.address   IS NOT DISTINCT FROM m.supplier_address
   AND sp.city      IS NOT DISTINCT FROM m.supplier_city
   AND sp.country   IS NOT DISTINCT FROM m.supplier_country;

-- ============================================
-- LOAD FACT: Sales
-- ============================================
INSERT INTO fact_sales (
    sale_date,
    customer_id,
    seller_id,
    product_id,
    sale_quantity,
    sale_total_price
)
SELECT
    m.sale_date,
    c.id  AS customer_id,
    s.id  AS seller_id,
    p.id  AS product_id,
    m.sale_quantity,
    m.sale_total_price
FROM mock_data m
JOIN dim_customer c
    ON c.first_name   IS NOT DISTINCT FROM m.customer_first_name
   AND c.last_name    IS NOT DISTINCT FROM m.customer_last_name
   AND c.age          IS NOT DISTINCT FROM m.customer_age
   AND c.email        IS NOT DISTINCT FROM m.customer_email
   AND c.country      IS NOT DISTINCT FROM m.customer_country
   AND c.postal_code  IS NOT DISTINCT FROM m.customer_postal_code
   AND c.pet_type     IS NOT DISTINCT FROM m.customer_pet_type
   AND c.pet_name     IS NOT DISTINCT FROM m.customer_pet_name
   AND c.pet_breed    IS NOT DISTINCT FROM m.customer_pet_breed
JOIN dim_seller s
    ON s.first_name   IS NOT DISTINCT FROM m.seller_first_name
   AND s.last_name    IS NOT DISTINCT FROM m.seller_last_name
   AND s.email        IS NOT DISTINCT FROM m.seller_email
   AND s.country      IS NOT DISTINCT FROM m.seller_country
   AND s.postal_code  IS NOT DISTINCT FROM m.seller_postal_code
JOIN dim_store st
    ON st.name        IS NOT DISTINCT FROM m.store_name
   AND st.location    IS NOT DISTINCT FROM m.store_location
   AND st.city        IS NOT DISTINCT FROM m.store_city
   AND st.state       IS NOT DISTINCT FROM m.store_state
   AND st.country     IS NOT DISTINCT FROM m.store_country
   AND st.phone       IS NOT DISTINCT FROM m.store_phone
   AND st.email       IS NOT DISTINCT FROM m.store_email
JOIN dim_supplier sp
    ON sp.name        IS NOT DISTINCT FROM m.supplier_name
   AND sp.contact     IS NOT DISTINCT FROM m.supplier_contact
   AND sp.email       IS NOT DISTINCT FROM m.supplier_email
   AND sp.phone       IS NOT DISTINCT FROM m.supplier_phone
   AND sp.address     IS NOT DISTINCT FROM m.supplier_address
   AND sp.city        IS NOT DISTINCT FROM m.supplier_city
   AND sp.country     IS NOT DISTINCT FROM m.supplier_country
JOIN dim_product p
    ON p.product_name        IS NOT DISTINCT FROM m.product_name
   AND p.product_category    IS NOT DISTINCT FROM m.product_category
   AND p.product_price       IS NOT DISTINCT FROM m.product_price
   AND p.product_quantity    IS NOT DISTINCT FROM m.product_quantity
   AND p.pet_category        IS NOT DISTINCT FROM m.pet_category
   AND p.product_weight      IS NOT DISTINCT FROM m.product_weight
   AND p.product_color       IS NOT DISTINCT FROM m.product_color
   AND p.product_size        IS NOT DISTINCT FROM m.product_size
   AND p.product_brand       IS NOT DISTINCT FROM m.product_brand
   AND p.product_material    IS NOT DISTINCT FROM m.product_material
   AND p.product_description IS NOT DISTINCT FROM m.product_description
   AND p.product_rating      IS NOT DISTINCT FROM m.product_rating
   AND p.product_reviews     IS NOT DISTINCT FROM m.product_reviews
   AND p.product_release_date IS NOT DISTINCT FROM m.product_release_date
   AND p.product_expiry_date  IS NOT DISTINCT FROM m.product_expiry_date
   AND p.store_id    = st.id
   AND p.supplier_id = sp.id;

-- ============================================
-- ROW COUNTS VERIFICATION
-- ============================================
SELECT COUNT(*) FROM mock_data;
SELECT COUNT(*) FROM dim_store;
SELECT COUNT(*) FROM dim_supplier;
SELECT COUNT(*) FROM dim_customer;
SELECT COUNT(*) FROM dim_seller;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM fact_sales;