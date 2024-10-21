<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaflet Map with User Location</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <style>
        #map {
            height: 500px;
            width: 100%;
        }
    </style>
</head>
<body>

<h2>Display Accurate User's Current Location</h2>
<button onclick="getLocation()">Show My Location</button>

<!-- Map container -->
<div id="map"></div>

<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
<script>
    let map, marker;

    // Initialize the map with a default zoom level (it will be updated later with user's location)
    map = L.map('map').setView([20, 77], 5);  // Default view over India (broad view)

    // Load OpenStreetMap tiles
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
    }).addTo(map);

    // Function to get user's current location using the Geolocation API
    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showError, {
                enableHighAccuracy: true, // Request high accuracy
                timeout: 20000,           // Increased timeout to 20 seconds
                maximumAge: 0             // No cached location
            });
        } else {
            alert("Geolocation is not supported by this browser.");
        }
    }

    // Success callback: Use the user's current position to center and add a marker on the map
    function showPosition(position) {
        const lat = position.coords.latitude;
        const lng = position.coords.longitude;

        // Log the coordinates for debugging
        console.log(`Latitude: ${lat}, Longitude: ${lng}`);

        // Update map view to user's exact location
        map.setView([lat, lng], 15);

        // Add or update the marker to show user's position
        if (marker) {
            marker.remove(); // Remove previous marker if any
        }
        marker = L.marker([lat, lng]).addTo(map)
            .bindPopup('You are here!')
            .openPopup();
    }

    // Error callback for geolocation errors
    function showError(error) {
        switch (error.code) {
            case error.PERMISSION_DENIED:
                alert("Permission denied. Please allow location access.");
                break;
            case error.POSITION_UNAVAILABLE:
                alert("Location information is unavailable. Please check your GPS settings.");
                break;
            case error.TIMEOUT:
                alert("Request timed out. Please ensure you have a good internet connection.");
                break;
            case error.UNKNOWN_ERROR:
                alert("An unknown error occurred. Please try again.");
                break;
        }

        // Fallback to a default location (e.g., central point in India)
        console.log("Using fallback location.");
        map.setView([20, 77], 5); // Set map to a central point
    }
</script>

</body>
</html>
