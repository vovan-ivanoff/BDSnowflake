-- ============================================
-- DIMENSION: Customer
-- ============================================
CREATE TABLE dim_customer (
    id          SERIAL PRIMARY KEY,
    first_name  TEXT,
    last_name   TEXT,
    age         INT,
    email       TEXT,
    country     TEXT,
    postal_code TEXT,
    pet_type    TEXT,
    pet_name    TEXT,
    pet_breed   TEXT
);

-- ============================================
-- DIMENSION: Seller
-- ============================================
CREATE TABLE dim_seller (
    id          SERIAL PRIMARY KEY,
    first_name  TEXT,
    last_name   TEXT,
    email       TEXT,
    country     TEXT,
    postal_code TEXT
);

-- ============================================
-- DIMENSION: Store
-- ============================================
CREATE TABLE dim_store (
    id       SERIAL PRIMARY KEY,
    name     TEXT,
    location TEXT,
    city     TEXT,
    state    TEXT,
    country  TEXT,
    phone    TEXT,
    email    TEXT
);

-- ============================================
-- DIMENSION: Supplier
-- ============================================
CREATE TABLE dim_supplier (
    id      SERIAL PRIMARY KEY,
    name    TEXT,
    contact TEXT,
    email   TEXT,
    phone   TEXT,
    address TEXT,
    city    TEXT,
    country TEXT
);

-- ============================================
-- DIMENSION: Product
-- ============================================
CREATE TABLE dim_product (
    id                   SERIAL PRIMARY KEY,
    product_name         TEXT,
    product_category     TEXT,
    product_price        NUMERIC(10, 2),
    product_quantity     INT,
    pet_category         TEXT,
    product_weight       NUMERIC(10, 2),
    product_color        TEXT,
    product_size         TEXT,
    product_brand        TEXT,
    product_material     TEXT,
    product_description  TEXT,
    product_rating       NUMERIC(3, 1),
    product_reviews      INT,
    product_release_date TEXT,
    product_expiry_date  TEXT,
    store_id             INT,
    supplier_id          INT,

    CONSTRAINT fk_product_store
        FOREIGN KEY (store_id) REFERENCES dim_store (id),

    CONSTRAINT fk_product_supplier
        FOREIGN KEY (supplier_id) REFERENCES dim_supplier (id)
);

-- ============================================
-- FACT: Sales
-- ============================================
CREATE TABLE fact_sales (
    id               SERIAL PRIMARY KEY,
    sale_date        TEXT,
    customer_id      INT,
    seller_id        INT,
    product_id       INT,
    sale_quantity    INT,
    sale_total_price NUMERIC(10, 2),

    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_id) REFERENCES dim_customer (id),

    CONSTRAINT fk_sales_seller
        FOREIGN KEY (seller_id) REFERENCES dim_seller (id),

    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id) REFERENCES dim_product (id)
);