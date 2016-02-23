package org.ohdsi.jCdmBuilder;


public class Launcher {

	private final static int	MIN_HEAP	= 1200;

	public static void main(String[] args) throws Exception {

		float heapSizeMegs = (Runtime.getRuntime().maxMemory() / 1024) / 1024;

		if (heapSizeMegs > MIN_HEAP) {
			System.out.println("Launching with current VM");
			JCdmBuilderMain.main(args);
		} else {
			System.out.println("Starting new VM");
			String pathToJar = JCdmBuilderMain.class.getProtectionDomain().getCodeSource().getLocation().toURI().getPath();
			ProcessBuilder pb = new ProcessBuilder("java", "-Xmx" + MIN_HEAP + "m", "-classpath", pathToJar,
					" org.ohdsi.jCdmBuilder.JCdmBuilderMain");
			pb.start();
		}
	}
}
