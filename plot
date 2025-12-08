import numpy as np
import matplotlib.pyplot as plt

def U(L):
    """
    Hypothetical upvotes based purely on length L.
    Formula: -1/20 * L^2 + 3L
    """
    return -1/20 * L**2 + 3 * L

def G_single_type(L, p):# for cat type
    prob_existence = 1 - (1 - p)**L
    return prob_existence * U(L)

def G_two_types(L, p1, p2):# for cat+cute type
    prob_1 = 1 - (1 - p1)**L
    prob_2 = 1 - (1 - p2)**L
    prob_both = prob_1 * prob_2
    return prob_both * U(L)



L = np.linspace(0, 65, 600)


total_words = 15
p_cat = 2 / total_words
p_cute = 1 / total_words


u_values = U(L)
g_cat_values = G_single_type(L, p_cat)
g_cat_cute_values = G_two_types(L, p_cat, p_cute)

plt.figure(figsize=(12, 7))

# Plot U(L) - The theoretical ceiling
plt.plot(L, u_values, label='U(L): Potential Max Upvotes', 
         color='blue', linestyle='--', alpha=0.6)

# Plot G(L) for "cat"
plt.plot(L, g_cat_values, label=f'G(L): "cat" only (p={p_cat:.3f})', 
         color='green', linewidth=2)

# Plot G(L) for "cat" + "cute"
plt.plot(L, g_cat_cute_values, label=f'G(L): "cat" + "cute" (p_cute={p_cute:.3f})', 
         color='red', linewidth=2)


idx_max_u = np.argmax(u_values)
idx_max_cat = np.argmax(g_cat_values)
idx_max_cc = np.argmax(g_cat_cute_values)

plt.scatter(L[idx_max_u], u_values[idx_max_u], color='blue', zorder=5)
plt.scatter(L[idx_max_cat], g_cat_values[idx_max_cat], color='green', zorder=5)
plt.scatter(L[idx_max_cc], g_cat_cute_values[idx_max_cc], color='red', zorder=5)

plt.text(L[idx_max_u], u_values[idx_max_u]+1, 
         f'Max U\nL={L[idx_max_u]:.1f}', color='blue', ha='center')
plt.text(L[idx_max_cat], g_cat_values[idx_max_cat]-4, 
         f'Max "cat"\nL={L[idx_max_cat]:.1f}', color='green', ha='center')
plt.text(L[idx_max_cc], g_cat_cute_values[idx_max_cc]-4, 
         f'Max "cat+cute"\nL={L[idx_max_cc]:.1f}', color='red', ha='center')


plt.title('Optimization of Post Length: Generic vs. Specific Content Constraints')
plt.xlabel('Post Length (Number of Words)')
plt.ylabel('Expected Upvotes')
plt.legend()
plt.grid(True, alpha=0.3)
plt.axhline(0, color='black', linewidth=0.5)

plt.show()