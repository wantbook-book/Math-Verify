import pytest
from tests.test_all import compare_strings


@pytest.mark.parametrize("gold, pred, expected", [
    (
        r"$$\boxed{2}, \boxed{3}, \boxed{5}, \boxed{7}, \boxed{13}$$",
        r"$${2, 3, 5, 7, 13}$$",
        1,
    ),
    (
        r"$$f(y) = y$$",
        r"$$f(y) = y$$",
        1,
    ),
    (
        r"$$-793 < a < 10$$",
        r"$$(-793, 10)$$",
        1,
    ),
    (
        r"$$\text{The midpoints form a regular hexagon}$$",
        r"$$\text{The midpoints form a regular hexagon}$$",
        1,
    ),
    (
        r"$$a_3 = 2, a_{37} = 19$$",
        r"$$\boxed{a_{37} = 19, \quad a_3 = 2}$$",
        1,
    ),
    (
        r"$$(2, 2), (1, 3), (3, 3)$$",
        r"$$\boxed{(2, 2), (1, 3), (3, 3)}$$",
        1,
    ),
    (
        r"$$(1, +\infty)$$",
        r"$$(1, +\infty)$$",
        1,
    ),
    (
        r"$$x = \frac{1}{2}, x = \frac{-1 \pm \sqrt{13}}{4}$$",
        r"$$\boxed{x = \frac{1}{2}, x = \frac{-1 \pm \sqrt{13}}{4}}$$",
        1,
    ),
    (
        r"$$0.06 \text{ yuan}$$",
        r"$$\boxed{0.06 \text{ yuan}}$$",
        1,
    ),
    (
        r"$$(5, 8), (8, 5)$$",
        r"$$\boxed{(x, y) = (5, 8) \quad \text{and} \quad (8, 5)}$$",
        1,
    ),
    (
        r"$$667$$",
        r"$$\boxed{667}$$",
        1,
    ),
    (
        r"$$6 \text{ and } 8$$",
        r"$$\boxed{6 \text{ and } 8}$$",
        1,
    ),
    (
        r"$$(2, 2), (6, 2)$$",
        r"$$\boxed{(2, 2)} \quad \text{and} \quad \boxed{(6, 2)}$$",
        1,
    ),
    (
        r"$$(98, 2), (99, 503)$$",
        r"$$\boxed{(98, 2)} \quad \text{and} \quad \boxed{(99, 503)}$$",
        1,
    ),
    (
        r"$$(3, 3), (1, 1)$$",
        r"$$\boxed{(3, 3)} \text{ for part (a) and } \boxed{(1, 1)}$$",
        1,
    ),
    (
        r"$$k \ge 2$$",
        r"$$\boxed{k \ge 2}$$",
        1,
    ),
    (
        r"$$k = 45, n = 2$$",
        r"$$\boxed{k = 45} \quad \text{and} \quad \boxed{n = 2}$$",
        1,
    )
])
def test_numina_cases(gold, pred, expected):
    assert compare_strings(gold, pred, match_types=["latex", "expr"]) == expected