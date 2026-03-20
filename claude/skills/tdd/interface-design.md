# Interface Design for Testability

Good interfaces make testing natural:

1. **Accept dependencies, don't create them**

   ```java
   // Testable
   void processOrder(Order order, PaymentGateway paymentGateway) {}

   // Hard to test
   void processOrder(Order order) {
       StripeGateway gateway = new StripeGateway();
   }
   ```

2. **Return results, don't produce side effects**

   ```java
   // Testable
   Discount calculateDiscount(Cart cart) { ... }

   // Hard to test
   void applyDiscount(Cart cart) {
       cart.setTotal(cart.getTotal() - discount);
   }
   ```

3. **Small surface area**
   - Fewer methods = fewer tests needed
   - Fewer params = simpler test setup
