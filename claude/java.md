# General Development Skills – Øystein

Applies to all Java/Spring Boot projects unless overridden by a project-level skill file.

---

## Language and communication

- Code and all identifiers (variables, methods, classes, comments) are written in **English**
- Explanations and prose responses are in **Norwegian**
- When refactoring: always show **before and after**, with a brief explanation of why the change is better

---

## Java conventions

- Java 21 with Spring Boot (latest stable)
- **Never use star imports**, regardless of how many classes are imported
- Prefer `var` for local variables where the type is obvious from the right-hand side
- Use records for immutable data carriers
- Prefer `Optional` over `null` returns in service and repository layers

```java
// ✗
import org.springframework.web.bind.*;

// ✓
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
```

---

## Project structure

Organize by **feature/domain**, not by technical layer.

```
src/main/java/com/example/
├── invoice/
│   ├── InvoiceController.java
│   ├── InvoiceService.java
│   ├── InvoiceRepository.java
│   └── Invoice.java
├── customer/
│   └── ...
```

Never create top-level packages named `controller`, `service`, `repository`, or `model`.

---

## Spring Boot patterns

- Use `@RestController`, `@Service`, `@Repository` with constructor injection (never field injection)
- Configuration via `application.yml`, not `application.properties`
- No Spring Data JPA – use `JdbcTemplate` / `NamedParameterJdbcTemplate` with native queries
- SQL queries are inlined as text blocks in the repository class – keep them simple and move complexity into Java code that can be unit tested

```java
// ✗
@Autowired
private InvoiceRepository repository;

// ✓
private final InvoiceRepository repository;

public InvoiceService(InvoiceRepository repository) {
    this.repository = repository;
}
```

---

## SQL conventions

- Always name columns explicitly – never use `SELECT *`
- Use named parameters (`:paramName`), never positional (`?`)

```sql
-- ✗
SELECT * FROM invoice WHERE id = ?

-- ✓
SELECT id, customer_id, amount, created_at
FROM invoice
WHERE id = :id
```

---

## Testing

- **TDD by default**: write the test first, then the implementation
- JUnit 5 + Mockito
- Use `@ExtendWith(MockitoExtension.class)` – never `MockitoAnnotations.openMocks()`
- No `@SpringBootTest` in unit tests – use `@WebMvcTest`, `@DataJdbcTest`, or pure unit tests
- Test method naming: `methodName_givenCondition_expectedBehavior`

```java
@Test
void findById_givenUnknownId_throwsNotFoundException() {
    when(repository.findById(99L)).thenReturn(Optional.empty());

    assertThatThrownBy(() -> service.findById(99L))
        .isInstanceOf(NotFoundException.class);
}
```

---

## Architecture and design

- Follow SOLID principles; call out violations explicitly if spotted
- Prefer small, focused classes with a single responsibility
- Separate concerns: HTTP layer knows nothing about persistence, and vice versa
- Avoid leaking domain objects out of the service layer – use DTOs at the API boundary

---

## What to avoid

- Star imports
- Field injection with `@Autowired`
- `SELECT *` in SQL
- `@SpringBootTest` for unit tests
- Top-level technical layer packages (`controller/`, `service/`, etc.)
- Spring Data JPA repositories
