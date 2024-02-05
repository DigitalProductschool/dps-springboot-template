import React, { useState } from "react";
import axios from "axios";
import "./PhotoRestorerAi.css";

const PhotoRestorerAi = () => {
	const [selectedFile, setSelectedFile] = useState(null);
	const [originalImage, setOriginalImage] = useState(null);
	const [restoredImage, setRestoredImage] = useState(null);
	const [loading, setLoading] = useState(false);

	const handleFileChange = (event) => {
		setRestoredImage(null);
		setSelectedFile(event.target.files[0]);
		setOriginalImage(URL.createObjectURL(event.target.files[0]));
	};

	const handleRestore = async () => {
		try {
			setLoading(true);

			const formData = new FormData();
			formData.append("file", selectedFile);

			const response = await axios.post(
				"http://127.0.0.1:8000/restore_photo",
				formData,
				{
					headers: {
						"Content-Type": "multipart/form-data",
					},
					responseType: "arraybuffer",
				}
			);

			const restoredImageBlob = new Blob([response.data], {
				type: "image/png",
			});

			const restoredImageUrl = URL.createObjectURL(restoredImageBlob);

			setRestoredImage(restoredImageUrl);
		} catch (error) {
			console.error("Error restoring photo:", error);
		} finally {
			setLoading(false);
		}
	};

	return (
		<div className="photo-restorer-container">
			<div className="heading-description-container">
				<h3>Welcome to the AI side of the template!</h3>
				<p>
					This application allows you to restore old black and white
					photos using an AI-based colorization model. Upload an old
					photo, click {"Restore Photo"}, and compare the original and
					restored images.
				</p>
			</div>
			<input type="file" onChange={handleFileChange} />
			{originalImage && (
				<div className="image-container">
					<div className="image-section">
						<h4>Original Image</h4>
						<img src={originalImage} alt="Original" />
					</div>
					{restoredImage && (
						<div className="image-section">
							<h4>Restored Image</h4>
							<img src={restoredImage} alt="Restored" />
						</div>
					)}
				</div>
			)}
			<button
				onClick={handleRestore}
				className={`restore-button ${loading ? "loading" : ""}`}
				disabled={loading}
			>
				{loading ? "Restoring..." : "Restore Photo"}
			</button>
		</div>
	);
};

export default PhotoRestorerAi;
