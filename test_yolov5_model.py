import torch
from fastapi import FastAPI
from PIL import Image
import io

model = torch.hub.load('ultralytics/yolov5', 'custom', path='yolov5/runs/train/yolov5s_results/weights/best.pt', force_reload=True)

def predict_objects(image: Image.Image):
    # Perform inference
    results = model(image)
    
    # Show results
    results.show()
    # Extract detected labels
    detected_objects = results.pred[0]
    labels = [model.names[int(obj[5])] for obj in detected_objects]
    unique_labels = list(set(labels))
    print(unique_labels)
    return unique_labels

def search_recipe (ingredients):
    # Search recipe based on ingredients
    pass

# predict_objects('test_images/fruits-and-vegetable-rack-section.jpg')
