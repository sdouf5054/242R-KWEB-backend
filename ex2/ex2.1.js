const permutation = (n, r) => {
  let result = 1;
  for (let i = n; i > n - r; i--) {
    result *= i;
  }
  return result;
};

const combination = (n, r) => permutation(n, r) / permutation(r, r);

const multiPermutation = (n, r) => n ** r;

const multiCombination = (n, r) => combination(n + r - 1, r);

module.exports = {
  permutation,
  combination,
  multiPermutation,
  multiCombination,
};
