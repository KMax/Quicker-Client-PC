package quicker;

import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JTextArea;

public class QuickerWindow extends JFrame {
	private static final long serialVersionUID = 2835465704238280405L;
	private QuickerClient _controller;
	private JButton createButton;
	private JButton getButton;
	private JButton updateButton;
	private JButton deleteButton;
	private JButton getListButton;
	private JTextArea outputArea;
	
	public QuickerWindow(QuickerClient controller)
	{
		System.out.println("конструктор QuickerWindow отработал. ");
		_controller = controller;
		JFrame jfrm = new JFrame("Quicker client. ");
		jfrm.setLayout(new FlowLayout());
		jfrm.setSize(580, 640);
		
		jfrm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		// Buttons
		createButton = new JButton("Add note");
		createButton.setActionCommand("add");
		getButton = new JButton("Get note");
		getButton.setActionCommand("get");
		updateButton = new JButton("Update note");
		updateButton.setActionCommand("update");
		deleteButton = new JButton("Remove note");
		deleteButton.setActionCommand("remove");
		getListButton = new JButton("List notes");
		deleteButton.setActionCommand("list");

		jfrm.add(createButton);
		jfrm.add(getButton);
		jfrm.add(updateButton);
		jfrm.add(deleteButton);
		jfrm.add(getListButton);
		
		// Other
		
		outputArea = new JTextArea(80, 45);
		jfrm.add(outputArea);
		
		// listeners
		createButton.addActionListener(_controller);
		getButton.addActionListener(_controller);
		updateButton.addActionListener(_controller);
		deleteButton.addActionListener(_controller);
		getListButton.addActionListener(_controller);
		
		jfrm.setVisible(true);
	}
	public void printData(String data)
	{
		outputArea.append("\n" + data);
	}
}
