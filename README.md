# CountIt
An iOS macronutrient tracking app.

<a href="https://apps.apple.com/us/app/bananabite/id6502222485">
  <img src="https://upload.wikimedia.org/wikipedia/commons/3/3c/Download_on_the_App_Store_Badge.svg" alt="App Store" width="200 style="padding-bottom: 20px;"/>
</a>

## App Screenshots
<div style="display: flex; overflow-x: auto; margin-top: 20px;">
    <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/b9/62/27/b96227f8-23f2-549c-ee47-2bef68a1d9b8/home.png/400x800bb.png" alt="Home" width="200" style="margin-right: 10px;">
    <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/99/fa/e0/99fae00c-1f99-6aa7-b701-2b2782e6cb03/food.png/400x800bb.png" alt="Detail" width="200" style="margin-right: 10px;">
    <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/26/5c/d8/265cd820-a753-d0d6-67c8-7fd93bd23454/search.png/400x800bb.png" alt="Search" width="200" style="margin-right: 10px;">
    <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/50/32/86/50328693-5ed3-4a0b-1a2a-88396cf183cb/recipe.png/400x800bb.png" alt="Add" width="200" style="margin-right: 10px;">
    <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource211/v4/af/95/c5/af95c53f-eef7-459c-4e9b-2941574bf599/progress.png/400x800bb.png" alt="Goals" width="200" style="margin-right: 10px;">
    <img src="https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/dd/fa/ed/ddfaedb0-6f6f-d505-619f-19a8d9e3b3a5/progressDetail.png/400x800bb.png" alt="Widgets" width="200" style="margin-right: 10px;">
</div>

## Features
- Comprehensive nutrient information for food products using [USDA FoodData Central](https://fdc.nal.usda.gov/)
- Customizable widgets to visualize daily nutrients
- Barcode support
- Quick add feature
- Customizable serving size & quantity

## Installation

### Prerequisites
- iOS 17.0+
- Xcode 14.0+

### Build Steps
1. Clone the repo
  ```sh
   git clone https://github.com/timmypass17/banana-bite.git
   ```
2. Open `FoodApp.xcodeproj` using Xcode.
   
## Technologies used
- Swift
- UIKit (no storyboard)
- Core Data
- WidgetKit
- [USDA FoodData Central API](https://fdc.nal.usda.gov/api-guide.html)

## Acknowledgements
- [USDA FoodData Central](https://fdc.nal.usda.gov/)
  - Source of food data
