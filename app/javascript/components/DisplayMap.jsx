import React, { useRef, useEffect, useState } from "react";
import { Wrapper } from "@googlemaps/react-wrapper";

const apiKey = 'AIzaSyDzBItEXF35b3DW-L4vdsiwZEnhTj1esx4'

function MyMap() {
  const ref = useRef(null);
  const [map, setMap] = useState();

  useEffect(() => {
    if (ref.current && !map) {
      setMap(
        new window.google.maps.Map(ref.current, {
          center: { lat: 35.681236, lng: 139.767125 }, // 東京駅
          zoom: 15,
        })
      );
    }
  }, [ref, map]);

  useEffect(() => {
    if (map) {
      new window.google.maps.Marker({
        position: { lat: 35.681236, lng: 139.767125 },
        map,
        title: "東京駅",
      });
    }
  }, [map]);

  return <div ref={ref} style={{ width: "100%", height: "100%" }} />;
}

function DisplayMap({apiKey}) {
  return (
    <Wrapper apiKey={apiKey} libraries={["places"]}>
      <MyMap />
    </Wrapper>
  );
}

export default DisplayMap;