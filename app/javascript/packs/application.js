import React from "react"
import { createRoot } from "react-dom/client";
import DisplayMap from "components/DisplayMap"

  const root = createRoot(document.getElementById("map_area"))
  const apiKey = document.getElementById('map_area').dataset.apiKey
  if (root) {
    root.render(<DisplayMap apiKey={apiKey} />) 
  }
