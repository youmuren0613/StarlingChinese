// =================================================================================================
//
//	Starling Framework
//	Copyright 2011 Gamua OG. All Rights Reserved.
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================
//
// easing functions thankfully taken from http://dojotoolkit.org
//                                    and http://www.robertpenner.com/easing
//

package starling.animation
{
    import flash.utils.Dictionary;
    
    import starling.errors.AbstractClassError;
    
    /** Transitions(过渡)类包含了一些静态方法，来定义缓动相关的函数。这些函数被用在Tween类执行动画的时候。
     * 
     *  <p>关于transitions这里有一张很直观的图片描述：</p> 
     *  <img src="http://gamua.com/img/blog/2010/sparrow-transitions.png"/>
     *  
     *  <p>您可以使用"registerTransition" 方法来自定义过渡方式. 一个过渡的实现方法必须遵循下面的语法, 其中 ratio 的取值范围是 0-1:</p>
     *  
     *  <pre>function myTransition(ratio:Number):Number</pre>
     */
    public class Transitions
    {        
        public static const LINEAR:String = "linear";
        public static const EASE_IN:String = "easeIn";
        public static const EASE_OUT:String = "easeOut";
        public static const EASE_IN_OUT:String = "easeInOut";
        public static const EASE_OUT_IN:String = "easeOutIn";        
        public static const EASE_IN_BACK:String = "easeInBack";
        public static const EASE_OUT_BACK:String = "easeOutBack";
        public static const EASE_IN_OUT_BACK:String = "easeInOutBack";
        public static const EASE_OUT_IN_BACK:String = "easeOutInBack";
        public static const EASE_IN_ELASTIC:String = "easeInElastic";
        public static const EASE_OUT_ELASTIC:String = "easeOutElastic";
        public static const EASE_IN_OUT_ELASTIC:String = "easeInOutElastic";
        public static const EASE_OUT_IN_ELASTIC:String = "easeOutInElastic";  
        public static const EASE_IN_BOUNCE:String = "easeInBounce";
        public static const EASE_OUT_BOUNCE:String = "easeOutBounce";
        public static const EASE_IN_OUT_BOUNCE:String = "easeInOutBounce";
        public static const EASE_OUT_IN_BOUNCE:String = "easeOutInBounce";
        
        private static var sTransitions:Dictionary;
        
        /** @private */
        public function Transitions() { throw new AbstractClassError(); }
        
        /** 通过指定一个唯一的名称，获取过渡的实现方法 */ 
        public static function getTransition(name:String):Function
        {
            if (sTransitions == null) registerDefaults();
            return sTransitions[name];
        }
        
        /** 通过指定一个唯一的名称，注册一个过渡的实现方法 */
        public static function register(name:String, func:Function):void
        {
            if (sTransitions == null) registerDefaults();
            sTransitions[name] = func;
        }
        
        private static function registerDefaults():void
        {
            sTransitions = new Dictionary();
            
            register(LINEAR, linear);
            register(EASE_IN, easeIn);
            register(EASE_OUT, easeOut);
            register(EASE_IN_OUT, easeInOut);
            register(EASE_OUT_IN, easeOutIn);
            register(EASE_IN_BACK, easeInBack);
            register(EASE_OUT_BACK, easeOutBack);
            register(EASE_IN_OUT_BACK, easeInOutBack);
            register(EASE_OUT_IN_BACK, easeOutInBack);
            register(EASE_IN_ELASTIC, easeInElastic);
            register(EASE_OUT_ELASTIC, easeOutElastic);
            register(EASE_IN_OUT_ELASTIC, easeInOutElastic);
            register(EASE_OUT_IN_ELASTIC, easeOutInElastic);
            register(EASE_IN_BOUNCE, easeInBounce);
            register(EASE_OUT_BOUNCE, easeOutBounce);
            register(EASE_IN_OUT_BOUNCE, easeInOutBounce);
            register(EASE_OUT_IN_BOUNCE, easeOutInBounce);
        }         
        
        // transition functions
        
        private static function linear(ratio:Number):Number
        {
            return ratio;
        }
        
        private static function easeIn(ratio:Number):Number
        {
            return ratio * ratio * ratio;
        }    
        
        private static function easeOut(ratio:Number):Number
        {
            var invRatio:Number = ratio - 1.0;
            return invRatio * invRatio * invRatio + 1;
        }        
        
        private static function easeInOut(ratio:Number):Number
        {
            return easeCombined(easeIn, easeOut, ratio);
        }   
        
        private static function easeOutIn(ratio:Number):Number
        {
            return easeCombined(easeOut, easeIn, ratio);
        }
        
        private static function easeInBack(ratio:Number):Number
        {
            var s:Number = 1.70158;
            return Math.pow(ratio, 2) * ((s + 1.0)*ratio - s);
        }
        
        private static function easeOutBack(ratio:Number):Number
        {
            var invRatio:Number = ratio - 1.0;            
            var s:Number = 1.70158;
            return Math.pow(invRatio, 2) * ((s + 1.0)*invRatio + s) + 1.0;
        }
        
        private static function easeInOutBack(ratio:Number):Number
        {
            return easeCombined(easeInBack, easeOutBack, ratio);
        }   
        
        private static function easeOutInBack(ratio:Number):Number
        {
            return easeCombined(easeOutBack, easeInBack, ratio);
        }        
        
        private static function easeInElastic(ratio:Number):Number
        {
            if (ratio == 0 || ratio == 1) return ratio;
            else
            {
                var p:Number = 0.3;
                var s:Number = p/4.0;
                var invRatio:Number = ratio - 1;
                return -1.0 * Math.pow(2.0, 10.0*invRatio) * Math.sin((invRatio-s)*(2.0*Math.PI)/p);                
            }            
        }
        
        private static function easeOutElastic(ratio:Number):Number
        {
            if (ratio == 0 || ratio == 1) return ratio;
            else
            {
                var p:Number = 0.3;
                var s:Number = p/4.0;                
                return Math.pow(2.0, -10.0*ratio) * Math.sin((ratio-s)*(2.0*Math.PI)/p) + 1;                
            }            
        }
        
        private static function easeInOutElastic(ratio:Number):Number
        {
            return easeCombined(easeInElastic, easeOutElastic, ratio);
        }   
        
        private static function easeOutInElastic(ratio:Number):Number
        {
            return easeCombined(easeOutElastic, easeInElastic, ratio);
        }
        
        private static function easeInBounce(ratio:Number):Number
        {
            return 1.0 - easeOutBounce(1.0 - ratio);
        }
        
        private static function easeOutBounce(ratio:Number):Number
        {
            var s:Number = 7.5625;
            var p:Number = 2.75;
            var l:Number;
            if (ratio < (1.0/p))
            {
                l = s * Math.pow(ratio, 2);
            }
            else
            {
                if (ratio < (2.0/p))
                {
                    ratio -= 1.5/p;
                    l = s * Math.pow(ratio, 2) + 0.75;
                }
                else
                {
                    if (ratio < 2.5/p)
                    {
                        ratio -= 2.25/p;
                        l = s * Math.pow(ratio, 2) + 0.9375;
                    }
                    else
                    {
                        ratio -= 2.625/p;
                        l =  s * Math.pow(ratio, 2) + 0.984375;
                    }
                }
            }
            return l;
        }
        
        private static function easeInOutBounce(ratio:Number):Number
        {
            return easeCombined(easeInBounce, easeOutBounce, ratio);
        }   
        
        private static function easeOutInBounce(ratio:Number):Number
        {
            return easeCombined(easeOutBounce, easeInBounce, ratio);
        }
        
        private static function easeCombined(startFunc:Function, endFunc:Function, ratio:Number):Number
        {
            if (ratio < 0.5) return 0.5 * startFunc(ratio*2.0);
            else             return 0.5 * endFunc((ratio-0.5)*2.0) + 0.5;
        }
    }
}