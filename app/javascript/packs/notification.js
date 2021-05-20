document.addEventListener("turbolinks:load", () => {
	const notification = document.querySelector('.alert');
	if (notification) {
		window.setTimeout(() => {
			notification.style.display = "none"
		}, 5000);
	}
});
