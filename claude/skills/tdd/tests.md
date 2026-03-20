# Good and Bad Tests

## Good Tests

**Integration-style**: Test through real interfaces, not mocks of internal parts.

```java
// GOOD: Tests observable behavior
@Test
void userCanCheckoutWithValidCart() {
    Cart cart = createCart();
    cart.add(product);
    CheckoutResult result = checkout(cart, paymentMethod);
    assertEquals("confirmed", result.getStatus());
}
```

Characteristics:

- Tests behavior users/callers care about
- Uses public API only
- Survives internal refactors
- Describes WHAT, not HOW
- One logical assertion per test

## Bad Tests

**Implementation-detail tests**: Coupled to internal structure.

```java
// BAD: Tests implementation details
@Test
void checkoutCallsPaymentServiceProcess() {
    PaymentService mockPayment = mock(PaymentService.class);
    checkout(cart, mockPayment);
    verify(mockPayment).process(cart.getTotal());
}
```

Red flags:

- Mocking internal collaborators
- Testing private methods
- Asserting on call counts/order
- Test breaks when refactoring without behavior change
- Test name describes HOW not WHAT
- Verifying through external means instead of interface

```java
// BAD: Bypasses interface to verify
@Test
void createUserSavesToDatabase() {
    createUser(new UserData("Alice"));
    User row = jdbcTemplate.queryForObject(
        "SELECT * FROM users WHERE name = ?", userMapper, "Alice");
    assertNotNull(row);
}

// GOOD: Verifies through interface
@Test
void createUserMakesUserRetrievable() {
    User user = createUser(new UserData("Alice"));
    User retrieved = getUser(user.getId());
    assertEquals("Alice", retrieved.getName());
}
```
