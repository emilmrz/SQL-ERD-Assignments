# Assignment explanations and verification notes

## Reporting conventions
The reference database is immutable during reporting. The `Sales` column already stores an entire order amount; do not multiply it by `Quantity`. A qualifying commercial sale (Scenarios 4 and 6) is Shipped/Delivered, with a non-NULL `ShipDate >= OrderDate`. OrderDate determines the reporting period.

## Scenario 1: No orders versus filtered activity
A customer with no orders has no matching `Orders` row at all (task 1.4). A customer may have orders but none eligible for a specific October campaign; this is not the same as never having ordered.

## Scenario 2: Dates
`ShipDate` records dispatch, not delivery arrival. The provided record 202 has a 10-day dispatch delay. Tasks 2.5–2.7 create **fictional temporary records** because order IDs 105, 110 and 999 are absent from the reference dataset; these modifications exist only in the practice copy.

## Scenario 3: Product and employee analysis
Task 3.4 ranks products by sum of `Quantity`, not revenue. Task 3.6 sums the stored Sales values without filtering, as the original scenario instructs. Products with no orders are retained with a LEFT JOIN.

## Scenario 4: Filter example and JOIN example
**4.2 (filter):** Order 205 meets the October qualifying-sale, German customer, Electronics category and customer Score >=500 criteria. An October Pending electronics order such as 212 is excluded even if the customer has a high Score, because the qualifying-sale conditions are mandatory for both branches of the OR.

**4.1 (JOIN):** An order is joined to Customers, Products, and Employees through CustomerID, ProductID, and SalesPersonID. Each order retains one row because these three keys identify one matching entity each, rather than multiplying results through unrelated joins.

## Scenario 5: Filter example and JOIN example
**5.5 (filter):** Order 221 is flagged because its status is Shipped but ShipDate is NULL. A Pending order with ShipDate NULL is not flagged by that condition alone because a pending order is not marked Shipped or Delivered.

**5.7 (LEFT JOIN):** All Sales employees appear even if they have no pending, unshipped orders. Conditions on pending status and ShipDate are placed in the join clause, and COALESCE converts a missing sum to zero.

## Scenario 6: Filter example and JOIN example
**6.4 (filter):** Qualifying October orders are selected before aggregation; a salesperson must have both at least two such orders and at least 1,000 in their combined Sales values. `HAVING` implements these conditions after grouping, so Pending orders cannot help reach the target.

**6.3 (JOIN):** The manager is joined to employees with `Employees.ManagerID = manager.EmployeeID`, then to those direct reports’ qualifying October orders. This excludes the manager's own Sales and avoids including indirect reports, while a LEFT JOIN retains direct reports with no matching orders.

## Empty results
An empty CSV (headers only) means there were no matching records under the given constraints. It does not justify changing the reference data or query requirements.

## Relationship explanations — Project A
- Customers 1 to 0..many Orders, each Order exactly 1 Customer.
- Products 1 to 0..many Orders, each Order exactly 1 Product (this simplified model has no OrderItems).
- Employees 1 to 0..many Orders, each Order exactly 1 assigned salesperson/employee.
- Employees self-reference: an employee has 0 or 1 manager; a manager can supervise 0..many employees.

## Relationship explanations — Project B
- An Instructor teaches 0..many Courses, each Course is taught by exactly one Instructor.
- A Student has 0..many Enrollments; each Enrollment belongs to exactly one Student.
- A Course has 0..many Enrollments; each Enrollment belongs to exactly one Course.
- Students and Courses are M:N conceptually, implemented with Enrollments. A UNIQUE(StudentID, CourseID) constraint prevents registering the same student for the same course twice.
