function states_s = state_extraction(SimOut)
    u = SimOut.Vehicle.EOM.AirRelativeData.Vel_bWb.Data(:,1);
    v = SimOut.Vehicle.EOM.AirRelativeData.Vel_bWb.Data(:,2);
    w = SimOut.Vehicle.EOM.AirRelativeData.Vel_bWb.Data(:,3);
    
    phi = SimOut.Vehicle.Sensor.Euler.phi.Data * 180/pi;
    theta = SimOut.Vehicle.Sensor.Euler.theta.Data * 180/pi;
    psi = SimOut.Vehicle.Sensor.Euler.psi.Data * 180/pi;
    
    p = SimOut.Vehicle.Sensor.Omeg_BIb.Data(:,1) * 180/pi;
    q = SimOut.Vehicle.Sensor.Omeg_BIb.Data(:,2) * 180/pi;
    r = SimOut.Vehicle.Sensor.Omeg_BIb.Data(:,3) * 180/pi;
    
    dal = SimOut.Vehicle.SurfAct.Position.Data(:,1) * 180/pi;
    dar = SimOut.Vehicle.SurfAct.Position.Data(:,2) * 180/pi;
    del = SimOut.Vehicle.SurfAct.Position.Data(:,3) * 180/pi;
    der = SimOut.Vehicle.SurfAct.Position.Data(:,4) * 180/pi;
    dr = SimOut.Vehicle.SurfAct.Position.Data(:,5) * 180/pi;
    
    dal_cmd = SimOut.Control.Cmd.CtrlSurfaceCmd.Data(:,1) * 180/pi;
    dar_cmd = SimOut.Control.Cmd.CtrlSurfaceCmd.Data(:,2) * 180/pi;
    del_cmd = SimOut.Control.Cmd.CtrlSurfaceCmd.Data(:,3) * 180/pi;
    der_cmd = SimOut.Control.Cmd.CtrlSurfaceCmd.Data(:,4) * 180/pi;
    dr_cmd = SimOut.Control.Cmd.CtrlSurfaceCmd.Data(:,5) * 180/pi;
    
    tau9 = SimOut.Vehicle.PropAct.EngSpeed.Data(:, 9) * (60/(2*pi));
    tau9_cmd = SimOut.Control.Cmd.EngineCmd.Data(:,9) * (60/(2*pi));
    
    states_s = [u, v, w, phi, theta, psi, p, q, r, dal, dar, del, der, dr, dal_cmd, dar_cmd, del_cmd, der_cmd, dr_cmd, tau9, tau9_cmd];
end