# EcomPaymentDisbursement

Application provides ecommerce shops (merchants) a flexible payment method so their customers (shoppers) can purchase and receive goods without paying upfront. however, we are charging a small fees per purchase and pays out (disburse) the merchant once the order is marked as completed.

Disbursements are done weekly on Monday. We disburse only orders which status is completed.

Pricing rule:
  * 1% fee for amounts smaller than 50 €
  * 0.95% for amounts between 50€ - 300€
  * 0.85% for amounts over 300€

## How it works

To start application you need to follow below steps:
  1. Clone from my repo with `git clone https://github.com/niteshcode4u/ecom_payment_disbursement.git`
  2. Install dependencies with `mix deps.get`
  3. Create your database with `mix ecto.create`
  4. Migrate your database with `mix ecto.migrate`
  5. Seed the database with `mix run priv/repo/seeds.exs`
  6. Start the application with  `iex -S mix phx.server`

Once application is running all we need to do is make call with below data
  1. Method: `Get`
  2. URLs
  - `http://localhost:4000/api/disbursements?date=2022-11-19`
  - `http://localhost:4000/api/disbursements?date=2022-11-19&merchant_id=10`
    
    
    ```
      [
        {
          "amount": 1918.3686999999998,
          "date_of_disbursement": "2022-11-19",
          "merchant_email": "info@schoen-inc.com",
          "merchant_id": "10",
          "merchant_name": "Schoen Inc"
        }
      ]
      
      
      [
        {
          "amount": 12.2,
          "date_of_disbursement": "2022-11-19",
          "merchant_email": "info@flatley-rowe.com",
          "merchant_id": "1",
          "merchant_name": "Flatley-Rowe"
        },
        {
          "amount": 1918.3686999999998,
          "date_of_disbursement": "2022-11-19",
          "merchant_email": "info@schoen-inc.com",
          "merchant_id": "10",
          "merchant_name": "Schoen Inc"
        }
        ... so on based on merchant
      ]
    ```

## Test Coverage
![Screenshot 2022-11-21 at 6 11 36 AM](https://user-images.githubusercontent.com/20892499/202939819-aa9eab77-ab3b-4fa2-910a-001d62cca315.png)

## Area of ennchancement
Application is working super fine. however, there is always an area of enhancements. Due to limited time I haven't done few things but I guess below listed changes should have been done

  1. Validations need to be added propely and also error cases
  2. Disburment calculation is being done mechant-wise but better we can handle using message queue and create batching to insert in batch
  3. Accepting `Date` in format of `yyyy-mm-dd` only eg: `2022-11-19`. we should be handling error properly in case different format and also, need to accept oterh formatted date
  4. While passing merchant into request we are accepting only merchant_id for now however, we mayu change to multi options like `merchant_email`, `cif`, etc.
  5. Have added schema for all tables but left writing models as felt it's not in scope for this time. However models(module to perform CRUD) should be there for all.
  6. Added seed file there i hvae wirtten code to insert all using file. Can be modifiied and done using proper model call
  7. Using time as UTC+00:00 can be changes absed on requirement
