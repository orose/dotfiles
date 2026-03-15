# Frontend Development Skills – Øystein

Applies to all React/TypeScript projects unless overridden by a project-level skill file.

---

## Language and communication

- Code and all identifiers are written in **English**
- Explanations and prose responses are in **Norwegian**
- When refactoring: always show **before and after**, with a brief explanation of why the change is better

---

## Stack

- TypeScript with React (functional components and hooks only)
- Vite for bundling, Vitest for testing
- React Router for navigation

---

## TypeScript conventions

- Always prefer explicit types over inferred where it aids readability at API boundaries
- No `any` – use `unknown` and narrow explicitly if the type is truly unknown
- Prefer `type` over `interface` for props and data shapes; use `interface` only when extension/merging is intentional
- Use discriminated unions over boolean flags to model state

```typescript
// ✗
const [isLoading, setIsLoading] = useState(false);
const [isError, setIsError] = useState(false);

// ✓
type Status = "idle" | "loading" | "success" | "error";
const [status, setStatus] = useState<Status>("idle");
```

---

## Components

- Functional components only – no class components
- **Named exports always** – no default exports
- One component per file; filename matches the component name exactly
- Props typed explicitly with a `type` alias defined just above the component

```typescript
// ✗
export default function UserCard({ name }: { name: string }) { ... }

// ✓
type UserCardProps = {
  name: string;
  email: string;
};

export function UserCard({ name, email }: UserCardProps) { ... }
```

---

## Hooks

- Extract logic into custom hooks when a component has more than trivial state or side effects
- Custom hook files are named `use<Feature>.ts` and co-located with the feature
- Hooks never return JSX – they return data and callbacks only

```typescript
// ✓ – logic extracted, component stays presentational
export function useInvoice(id: string) {
  const [invoice, setInvoice] = useState<Invoice | null>(null);
  // fetch logic...
  return { invoice, isLoading };
}
```

---

## Project structure

Organize by **feature/domain**, mirroring the backend convention.

```
src/
├── invoice/
│   ├── InvoicePage.tsx
│   ├── InvoiceCard.tsx
│   ├── useInvoice.ts
│   └── invoice.types.ts
├── customer/
│   └── ...
├── shared/
│   └── components/
└── router.tsx
```

Never create top-level folders named `components`, `hooks`, `pages`, or `utils` as the primary structure.

---

## Testing

- Vitest + React Testing Library
- Test behaviour, not implementation – query by role and label, not by class or test-id where avoidable
- Co-locate test files with the component: `InvoiceCard.test.tsx` next to `InvoiceCard.tsx`
- Custom hooks are tested with `renderHook` in isolation

```typescript
// ✗
expect(container.querySelector(".invoice-title")).toHaveTextContent("INV-001");

// ✓
expect(screen.getByRole("heading", { name: "INV-001" })).toBeInTheDocument();
```

---

## What to avoid

- Default exports
- Class components
- `any` type
- Boolean flag pairs to model state (use discriminated unions)
- Inline anonymous functions as props where it hurts readability
- Top-level technical folders as primary structure (`components/`, `hooks/`, `pages/`)
