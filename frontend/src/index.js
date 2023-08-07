import React, { StrictMode } from "react";
import ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";

const rootElement = document.getElementById("root");
ReactDOM.render(
	<StrictMode>
		<BrowserRouter>Welcome to the DPS!</BrowserRouter>
	</StrictMode>,
	rootElement
);
