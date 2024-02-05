import React, { StrictMode } from "react";
import ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";
import PhotoRestorerAi from "./components/PhotoRestorerAi/PhotoRestorerAi";

const rootElement = document.getElementById("root");
ReactDOM.render(
	<StrictMode>
		<BrowserRouter>Welcome to the DPS!</BrowserRouter>
		<PhotoRestorerAi />
	</StrictMode>,
	rootElement
);
