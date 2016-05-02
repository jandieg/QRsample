package com.rener.wvqrscan;

import android.app.Activity;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.util.DisplayMetrics;
import android.util.TypedValue;
import android.widget.FrameLayout;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * Created by Gabrysia on 4/24/2016.
 */
public class WVQRScanManager extends CordovaPlugin {

    private Activity mActivity;
    private ZBarScannerActivity fragment;
    private FragmentManager fragmentManager;
    private CallbackContext mCallbackContext;

    private int containerViewId = 1;

    /**
     * Constructor.
     */
    public WVQRScanManager() {
    }

    /**
     * Sets the context of the Command. This can then be used to do things like
     * get file paths associated with the Activity.
     *
     * @param cordova The context of the main Activity.
     * @param webView The CordovaWebView Cordova is running in.
     */
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        mActivity = cordova.getActivity();
        fragmentManager = mActivity.getFragmentManager();
    }

    /**
     * Executes the request and returns PluginResult.
     *
     * @param action            The action to execute.
     * @param args              JSONArry of arguments for the plugin.
     * @param callbackContext   The callback id used when calling back into JavaScript.
     * @return                  True if the action was valid, false if not.
     */
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        mCallbackContext = callbackContext;
        if ("setQrReader".equals(action)) {
            startCamera(args, callbackContext);
            return true;
        } else if ("close".equals(action)) {
            stopCamera();
        }

        return false;
    }

    private boolean startCamera(final JSONArray args, CallbackContext callbackContext) {
        if(fragment == null){
            fragment = new ZBarScannerActivity();
            fragment.setManager(this);

            cordova.getActivity().runOnUiThread(new Runnable() {
                @Override
                public void run() {

                    try {
                        DisplayMetrics metrics = cordova.getActivity().getResources().getDisplayMetrics();
                        int x = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PX, args.getInt(0), metrics);
                        int y = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PX, args.getInt(1), metrics);
                        int width = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PX, args.getInt(2), metrics);
                        int height = (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_PX, args.getInt(3), metrics);

                        fragment.setRect(x, y, width, height);

                        //create or update the layout params for the container view
                        FrameLayout containerView = (FrameLayout)cordova.getActivity().findViewById(containerViewId);
                        if(containerView == null){
                            containerView = new FrameLayout(cordova.getActivity().getApplicationContext());
                            containerView.setId(containerViewId);

                            FrameLayout.LayoutParams containerLayoutParams = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT);
                            cordova.getActivity().addContentView(containerView, containerLayoutParams);
                        }

                        //add the fragment to the container
                        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                        fragmentTransaction.add(containerView.getId(), fragment);
                        fragmentTransaction.commit();
                    }
                    catch(Exception e){
                        e.printStackTrace();
                    }
                }
            });
        }
        return true;
    }

    private void stopCamera() {
        fragmentManager.beginTransaction().remove(fragment).commit();
        fragment = null;
    }

    public void onDataScaned(String data){
        mCallbackContext.success(data);
    }
}
