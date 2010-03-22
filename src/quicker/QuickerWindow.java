package quicker;

import java.awt.AWTException;
import java.awt.FlowLayout;
import java.awt.MenuItem;
import java.awt.PopupMenu;
import java.awt.SystemTray;
import java.awt.TrayIcon;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowEvent;
import java.awt.event.WindowStateListener;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
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
	public JTextArea outputArea;
	
	private SystemTray tray;
	private TrayIcon icon;
	
	public QuickerWindow(QuickerClient controller)
	{
		super("Quicker client. ");
		setVisible(true);
		setState(JFrame.ICONIFIED);
		tray = SystemTray.getSystemTray();
		try {
			icon = new TrayIcon(ImageIO.read(new File("ico.gif")));
		} catch (IOException e) {
			e.printStackTrace();
		}
		PopupMenu menu = new PopupMenu();
		MenuItem item = new MenuItem("Выход");
		menu.add(item);
		icon.setPopupMenu(menu);
		
		
		_controller = controller;
		setLayout(new FlowLayout());
		setSize(580, 640);
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
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
		getListButton.setActionCommand("list");

		add(createButton);
		add(getButton);
		add(updateButton);
		add(deleteButton);
		add(getListButton);
		
		// Other
		
		outputArea = new JTextArea(80, 45);
		add(outputArea);
		
		// listeners
		createButton.addActionListener(_controller);
		getButton.addActionListener(_controller);
		updateButton.addActionListener(_controller);
		deleteButton.addActionListener(_controller);
		getListButton.addActionListener(_controller);
		addWindowStateListener(new WindowStateListener() {
			
			@Override
			public void windowStateChanged(WindowEvent e) {
				if (e.getNewState() == JFrame.ICONIFIED) {
					setTrayIcon();
					setVisible(false);
				}
			}
		});
		icon.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				setVisible(true);
				setState(JFrame.NORMAL);
				tray.remove(icon);
			}
		});
		item.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent arg0) {
				System.exit(0);
			}
		});
		setDefaultLookAndFeelDecorated(true);
	}
	public void printData(String data)
	{
		outputArea.setText(data);
<<<<<<< HEAD
=======
	}
	public String getText()
	{
		return outputArea.getText();
	}
	
	// private methods
	
	private void setTrayIcon()
	{
		try {
			tray.add(icon);
			icon.displayMessage("Hello", "Welcome to Quicker", TrayIcon.MessageType.INFO);
		} catch (AWTException e) {
			e.printStackTrace();
		}
>>>>>>> 58a1e0aa37e536c5cf8e48c23c43d708bcfb3784
	}
}
