import gradio as gr
import os
import cv2
from modelscope.outputs import OutputKeys
from modelscope.pipelines import pipeline
from modelscope.utils.constant import Tasks
import PIL
import numpy as np
from gradio_imageslider import ImageSlider
import uuid

# Specify the output directory
output_dir = 'output'

# Check if the output directory exists, create it if not
if not os.path.exists(output_dir):
    os.makedirs(output_dir)
    print(f"Created '{output_dir}' directory.")

img_colorization = pipeline(Tasks.image_colorization, model='iic/cv_ddcolor_image-colorization')

def color(image):
    # Run colorization model
    output = img_colorization(image[...,::-1])
    result = output[OutputKeys.OUTPUT_IMG].astype(np.uint8)

    # Generate a meaningful filename based on the original file name
    unique_imgfilename = os.path.join(output_dir, str(uuid.uuid4()) + '.png')
    cv2.imwrite(unique_imgfilename, result)
    print('Inference finished!')
    return (image, unique_imgfilename)

title = "old_photo_restoration"
description = "Colorize old black and white photos."
examples = [[os.path.join('assets', 'tajmahal.jpeg'),],[os.path.join('assets', 'oldhouse.jpeg')]]

# Set up Gradio interface
demo = gr.Interface(
    fn=color,
    inputs="image",
    outputs=ImageSlider(position=0.5, label='Colored image with slider-view'),
    examples=examples,
    title=title,
    description=description,
    allow_flagging="never",
)

if __name__ == "__main__":
    # Launch the Gradio app on port 8000
    demo.launch(share=False, server_port=8000)
