using Godot;
using System;
//using System.Windows.Forms;

public partial class csharp_object : Node2D
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("csharp_object.cs:_Ready");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
		//GD.Print("csharp_object.cs:_Process");
	}
	
	public void on_click(GodotObject other)
	{
		GD.Print("csharp_object.cs:on_click:", other);
		HelloWorld.Main(null);
	}
}


public class HelloWorld
{
	public static void Main(string[] args)
	{
		Console.WriteLine ("Hello Mono World");
	}
}
/*
public class HelloWorld : Form
{
	static public void Main ()
	{
		Application.Run (new HelloWorld ());
	}

	public HelloWorld ()
	{
		Text = "Hello Mono World";
	}
}
*/
