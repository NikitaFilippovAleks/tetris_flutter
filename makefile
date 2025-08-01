run_web:
	flutter run -d chrome --web-experimental-hot-reload

generate:
	flutter pub get && \
	flutter pub run build_runner build --delete-conflicting-outputs
