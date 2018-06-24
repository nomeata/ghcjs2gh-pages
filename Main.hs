{-# LANGUAGE ForeignFunctionInterface  #-}
{-# LANGUAGE JavaScriptFFI     #-}
module Main (main) where

import Control.Applicative
import Control.Monad
import Control.Monad.Trans
import Optimisation.CirclePacking

-- import JavaScript.Canvas
-- import GHCJS.Types
-- import GHCJS.Foreign
-- import GHCJS.Marshal
import GHCJS.DOM
import GHCJS.DOM.Types
import GHCJS.DOM.Document
import GHCJS.DOM.Event
import GHCJS.DOM.EventM
import GHCJS.DOM.Element
import GHCJS.DOM.HTMLInputElement hiding (getWidth, getHeight)
import GHCJS.DOM.HTMLCanvasElement
import GHCJS.DOM.CanvasPath
import GHCJS.DOM.CanvasRenderingContext2D
import GHCJS.DOM.NonElementParentNode
import GHCJS.DOM.GlobalEventHandlers
import GHCJS.DOM.HTMLCollection
import Control.Concurrent

type Context = CanvasRenderingContext2D

-- | Main entry point.
main :: IO()
main = start

colors = ["Green","Silver", "Lime", "Gray", "Olive", "Yellow", "Maroon", "Navy", "Red", "Blue", "Purple", "Teal", "Fuchsia", "Aqua"]

start :: IO ()
start = do
  Just doc <- currentDocument

  body <- GHCJS.DOM.Document.getElementsByTagName doc "body"
  body <- itemUnsafe body 0
  body <- unsafeCastTo Element body
  setInnerHTML body bodySrc

  Just input <- getElementById doc "input"
  input <- unsafeCastTo HTMLInputElement input
  on input change (lift update)
  on input keyUp (lift update)

  update

update :: IO ()
update = do
  Just doc <- currentDocument
  Just canvas <- getElementById doc "can"
  canvas <- unsafeCastTo HTMLCanvasElement canvas

  w <- fromIntegral <$> getWidth canvas
  h <- fromIntegral <$> getHeight canvas

  context <- getContextUnsafe canvas "2d" ([] :: [Int])
  context <- unsafeCastTo CanvasRenderingContext2D context
  clearRect context 0 0 (realToFrac w) (realToFrac h)

  Just i <- getElementById doc "input"
  i <- unsafeCastTo HTMLInputElement i
  value <- getValue i
  let radii = map read (words value) :: [Double]

  let colored = zip radii (cycle colors)
  let packed = packCircles fst colored

  forM_ packed $ \res -> case res of
    ((r,c),(x,y)) -> do
        fillStyleNamed c context
        fillCircle context (x + w/2) (y + h/2) r

fillCircle :: Context -> Double -> Double -> Double -> IO ()
fillCircle ctx x y r = do
  beginPath ctx
  arc ctx x y r 0.0 (2.0 * pi) True
  closePath ctx
  fill ctx Nothing


-- JavaScript.Canvas.fillStyle does not allow for color names, so create our
-- own function here
foreign import javascript unsafe "$2.fillStyle = $1" js_fillStyleNamed :: JSString -> Context -> IO ()
fillStyleNamed :: String -> Context -> IO ()
fillStyleNamed f ctx = js_fillStyleNamed (toJSString f) ctx
{-# INLINE fillStyleNamed #-}

bodySrc :: String
bodySrc ="<div align=\"center\"> <canvas width=\"800\" height=\"500\" id=\"can\"></canvas><br/> <input style=\"width: 800px\" id=\"input\" value=\"50 32 30 30 40 35 5 20 43 18 12\"/><br/> <p style=\"width: 800px; text-align:justify; font-family:sans; font-size:80%\"> This is a small live demonstration of the Haskell library <a href=\"http://hackage.haskell.org/package/circle-packing\"><tt>circle-packing</tt></a> by <a href=\"http://www.joachim-breitner.de/\">Joachim Breitner</a>:<br/> Given a number of circles with their radii, this packags tries to arrange them tightly, without overlap and forming a large circle.<br/> Finding the optimal solution is NP hard, so only heuristics are feasible.</p> </div>"

