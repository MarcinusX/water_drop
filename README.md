# Water Drop 💦💦💦

A simple package for adding water drops to your Widgets!  

👇👇👇👇👇👇👇👇👇👇  
Blog article with detailed explanation:  
https://fidev.io/water-drop  
👆👆👆👆👆👆👆👆👆👆

![Demo](https://user-images.githubusercontent.com/16286046/77296593-412e7e80-6ce8-11ea-9a79-cb3909070886.gif) 

## Why?

Why not?!

## How?

Just wrap your widget in `WaterDrop` and provide `params`:
```dart
Widget build(BuildContext context) {
  return WaterDrop(
    child: _StaticCard(color: Colors.green),
    params: [
      WaterDropParam(top: 50, height: 70, left: 100, width: 50),
      WaterDropParam(top: 10, height: 100, left: 280, width: 100),
      WaterDropParam(top: 155, height: 35, left: 135, width: 35),
      WaterDropParam(top: 135, height: 40, left: 250, width: 30),
      WaterDropParam(top: 20, height: 40, left: 20, width: 40),
      WaterDropParam(top: 140, height: 50, left: 15, width: 40),
      WaterDropParam(top: 20, height: 30, left: 200, width: 30),
      WaterDropParam(top: 120, height: 20, left: 360, width: 20),
    ],
  );
}
```

Or if you want a single drop, use `WaterDrop.single`:
```dart
@override
Widget build(BuildContext context) {
  return WaterDrop.single(
    top: 50,
    height: 70,
    left: 100,
    width: 50,
    child: _StaticCard(color: Colors.green),
  );
}
```