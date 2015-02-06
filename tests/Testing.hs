module Testing where

import           Bencode
import           Torrent
import           THP
import           Control.Monad
import           Data.Digest.SHA1
import qualified Data.ByteString.Char8 as C

test :: IO ()
test = do
    file <- ifile
    print $ torrentize file 

ifile = C.readFile
    "/home/nick/stuff/[kickass.so]big.hero.6.2014.1080p.brrip.x264.yify.torrent"
    -- "/home/nick/stuff/[kickass.so]nicki.minaj.pinkprint.deluxe.mp3.2014.torrent"
    -- "/home/nick/stuff/slackware-14.1-install-dvd.torrent"
-- thefile = return $ C.pack $ "d8:announcekk

test2 :: IO()
test2 = do
    file <- ifile
    let Just Torrent { announce = ann
                , fileStuff = stuff
                , infoHash = inf
                } = torrentize file
        Right ints = stuff
        thp = THP_Req { info_hash  = inf
                      , peer_id    = Word160 23443 4321 423121 6342 890
                      , rport      = 542
                      , uploaded   = 0
                      , downloaded = 0
                      , left       = fromIntegral $ sum ints
                      , event      = Just Started
                      }
    resp <- contact (C.unpack ann) thp
    print resp