
# Blott Studio Mobile Assessment

Hi this app start to create by using Flutter Starter Kit develop by me
Link :https://github.com/KasunHasanga/flutter_getx_starter

Get API key from following API
API: https://finnhub.io/docs/api/market-news
add it to .env file
sample also available as
* .env.sample

## Getting Started

To run the application, follow these steps:

1. **Install FVM**
    - FVM (Flutter Version Management) is essential for managing Flutter versions. Install it from the terminal:

      ```sh
      pub global activate fvm
      ```

2. **Use Specific Flutter Version**
    - Set the Flutter version for this project:

      ```sh
      fvm use 3.22.1
      ```

3. **Running the Application**
    - This project includes three flavors: Production, Staging, and Development. Use the following commands to run the app with the desired flavor:

      **Production:**
      ```sh
      fvm flutter run -t lib/main_production.dart --flavor production
      ```

      **Staging:**
      ```sh
      fvm flutter run -t lib/main_staging.dart --flavor staging
      ```

      **Development:**
      ```sh
      fvm flutter run -t lib/main_development.dart --flavor development
      ```

4. **For get andorid Apk**
   - 
    ```sh
      fvm flutter build apk -t lib/main_production.dart --flavor production
      ```
## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
