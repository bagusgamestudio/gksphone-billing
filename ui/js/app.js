import { fetchNui, isEnvBrowser, DEV_MODE } from "./utils.js";
var isDarkMode = false;
var gksphoneFunctions = null;

document.addEventListener('DOMContentLoaded', () => {
    setTimeout(() => {
        if (window.gksphone) {
            gksphoneFunctions = window.gksphone;
            const darkCheck = window.gksphone.isDarkMode();
            if (darkCheck) {
                isDarkMode = true;
                document.body.classList.add("dark");
            } else {
                isDarkMode = false;
                document.body.classList.remove("dark");
            }
        }
    }, 100);
});

function BillShow(bill) {
    const billList = document.getElementById("billingList");
    billList.innerHTML = "";
    bill.forEach((element) => {
        const billItem = document.createElement("div");
        billItem.classList.add("billing_box");
        billItem.innerHTML = `
            <div class="billing_details">
                <div class="bill_target"> 
                    <div class="bill_label"> ${element.label} </div>
                </div>
                
                <div class="bill_amount"> 
                    <span>$${element.amount}</span>
                    <button class="pay_button" id="paynow_${element.id}">
                        Pay 
                    </button>
                </div>
            </div>
        `;

        const payButton = billItem.querySelector(`#paynow_${element.id}`);
        payButton.addEventListener("click", async () => {
            const text = "Processing Payment..."
            gksphoneFunctions.loadingPopup(text);
            await fetchNui("billing_pay", {id: element.id});
            gksphoneFunctions.closeLoadingPopup();
        });

        billList.appendChild(billItem);
    });
}

window.addEventListener('message', (event) => {
    if (!event.data) return;
    const e = event.data
    if (e.event === "getBills") {
        BillShow(e.bills);
    }
})