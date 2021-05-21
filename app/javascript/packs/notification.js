document.addEventListener("turbolinks:load", () => {
	const notification = document.querySelector('.global-notification');
	if (notification) {
		window.setTimeout(() => {
			notification.style.display = "none"
		}, 5000);
	}
});
