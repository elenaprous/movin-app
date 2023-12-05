import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
  };

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      // Regular styling
      style: "mapbox://styles/mapbox/streets-v10",
      // style: "mapbox://styles/tobiasmedia/clpmo00qw00z601po1zksfm27",
    });

    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html);

      const customMarker = document.createElement("div")
      if(marker.category.includes("school")) {
        customMarker.innerHTML = marker.marker_schools
      } else if(marker.category.includes("restaurant")) {
        customMarker.innerHTML = marker.marker_restaurants
      } else if(marker.category.includes("public transport stop")) {
        customMarker.innerHTML = marker.marker_transportation
      } else if(marker.category.includes("nightlife")) {
        customMarker.innerHTML = marker.marker_nightlife
      } else if(marker.category.includes("fitness club center")) {
        customMarker.innerHTML = marker.marker_gyms
      } else if(marker.category == "address") {
        customMarker.innerHTML = marker.marker_house
      } else {
        customMarker.innerHTML = marker.marker_supermarkets
      }

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) =>
      bounds.extend([marker.lng, marker.lat])
    );
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  }
}
