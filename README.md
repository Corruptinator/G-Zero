# G-Zero (Godot Engine Demo Project)
(Note: This project requires Godot 3.0 Alpha or the latest build from the [Master] Source Code Build.)

A Demo Project utilizing the Open Source Godot Engine to incorporate racing and gameplay core functions based on popular sci-fi racing games such as WipEOut or F-Zero.

This is an open-collaboration project where anybody in the Godot Game Engine community can contribute to make this neat little demo work for the Godot Engine Demo Templates. In this project, rather than using an ordinary VehicleBody, the main controlling object is a Rigidbody since it is possible to implement custom gravity depending on which direction it is going. This is hard to explain but hopefully the concept below can explain what I have theorized on how this can work:

![Theory](https://github.com/Corruptinator/G-Zero/blob/master/Concept_Art/G-Zero%20Physics%20Method.png)

As you can see, the idea is that using a raycast, we can tell the "Position" node on where to aim, using the "Gravity" node above the RigidBody which in theory can tell which way to fall towards to, or in other cases stay on the loop-de-loop track that allows anti-gravity driving to be possible.

The idea/bottom line is that this project can be used as an additional example to showcase the capabilities of the Godot Game Engine, by being part of the included demo projects when Godot 3.0 is released to the Public.
