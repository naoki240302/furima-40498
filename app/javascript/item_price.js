function setupPriceListener() {
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const inputValue = priceInput.value;
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(inputValue * 0.1);

      const addProfitDom = document.getElementById("profit");
      addProfitDom.innerHTML = Math.floor(inputValue - addTaxDom.innerHTML);
    });
  }
}

window.addEventListener('turbo:load', setupPriceListener);
window.addEventListener('turbo:render', setupPriceListener);
