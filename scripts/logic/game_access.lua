function mancala()
    return hasItem("mancala") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function dotsandboxes()
    return hasItem("dotsandboxes") and hasItem("major-boards-access") and hasItem("minor-paper-access")
end
function yacht()
    return hasItem("yacht") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function fourinarow()
    return hasItem("fourinarow") and hasItem("major-boards-access") and hasItem("minor-paper-access")
end
function hitandblow()
    return hasItem("hitandblow") and hasItem("major-boards-access") and hasItem("minor-paper-access")
end
function ninemensmorris()
    return hasItem("ninemensmorris") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function hex()
    return hasItem("hex") and hasItem("major-boards-access") and hasItem("minor-paper-access")
end
function checkers()
    return hasItem("checkers") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function hareandhounds()
    return hasItem("hareandhounds") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function gomoku()
    return hasItem("gomoku") and hasItem("major-boards-access") and hasItem("minor-jp-access")
end
function dominoes()
    return hasItem("dominoes") and hasItem("major-boards-access") and hasItem("minor-paper-access")
end
function chinesecheckers()
    return hasItem("chinesecheckers") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function ludo()
    return hasItem("ludo") and hasItem("major-boards-access") and hasItem("minor-paper-access")
end
function backgammon()
    return hasItem("backgammon") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function renegade()
    return hasItem("renegade") and hasItem("major-boards-access") and hasItem("minor-paper-access")
end
function chess()
    return hasItem("chess") and hasItem("major-boards-access") and hasItem("minor-wooden-access")
end
function shogi()
    return hasItem("shogi") and hasItem("major-boards-access") and hasItem("minor-jp-access")
end
function minishogi()
    return hasItem("minishogi") and hasItem("major-boards-access") and hasItem("minor-jp-access")
end
function hanafuda()
    return hasItem("hanafuda") and hasItem("major-cards-access") and hasItem("minor-jp-access")
end
function riichi()
    return hasItem("riichi") and hasItem("major-boards-access") and hasItem("minor-jp-access")
end
function lastcard()
    return hasItem("lastcard") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function blackjack()
    return hasItem("blackjack") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function holdem()
    return hasItem("holdem") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function president()
    return hasItem("president") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function sevens()
    return hasItem("sevens") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function speed()
    return hasItem("speed") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function matching()
    return hasItem("matching") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function war()
    return hasItem("war") and hasItem("major-cards-access") and hasItem("minor-non-jp-access")
end
function takoyaki()
    return hasItem("takoyaki") and hasItem("major-cards-access") and hasItem("minor-jp-access")
end
function pigstail()
    return hasItem("pigstail") and hasItem("major-cards-access") and hasItem("minor-jp-access")
end
function golf()
    return hasItem("golf") and hasItem("major-sports-access") and hasItem("minor-sophisticated-access")
end
function billiards()
    return hasItem("billiards") and hasItem("major-sports-access") and hasItem("minor-sophisticated-access")
end
function bowling()
    return hasItem("bowling") and hasItem("major-sports-access") and hasItem("minor-sophisticated-access")
end
function darts()
    return hasItem("darts") and hasItem("major-sports-access") and hasItem("minor-sophisticated-access")
end
function carrom()
    return hasItem("carrom") and hasItem("major-variety-access") and hasItem("minor-variety-access")
end
function tennis()
    return hasItem("tennis") and hasItem("major-sports-access") and hasItem("minor-toy-access")
end
function soccer()
    return hasItem("soccer") and hasItem("major-sports-access") and hasItem("minor-toy-access")
end
function curling()
    return hasItem("curling") and hasItem("major-sports-access") and hasItem("minor-toy-access")
end
function boxing()
    return hasItem("boxing") and hasItem("major-sports-access") and hasItem("minor-toy-access")
end
function baseball()
    return hasItem("baseball") and hasItem("major-sports-access") and hasItem("minor-toy-access")
end
function hockey()
    return hasItem("hockey") and hasItem("major-sports-access") and hasItem("minor-sophisticated-access")
end
function slotcars()
    return hasItem("slotcars") and hasItem("major-variety-access") and hasItem("minor-variety-access")
end
function fishing()
    return hasItem("fishing") and hasItem("major-variety-access") and hasItem("minor-variety-access")
end
function battletanks()
    return hasItem("battletanks") and hasItem("major-variety-access") and hasItem("minor-variety-access")
end
function teamtanks()
    return hasItem("teamtanks") and hasItem("major-variety-access") and hasItem("minor-variety-access")
end
function shootinggallery()
    return hasItem("shootinggallery") and hasItem("major-variety-access") and hasItem("minor-variety-access")
end
function sixballpuzzle()
    return hasItem("6ballpuzzle") and hasItem("major-variety-access") and hasItem("minor-variety-access")
end
function slidingpuzzle()
    return hasItem("slidingpuzzle") and hasItem("major-variety-access") and hasItem("minor-single-access")
end
function mahjong()
    return hasItem("mahjong") and hasItem("major-variety-access") and hasItem("minor-single-access")
end
function klondike()
    return hasItem("klondike") and hasItem("major-variety-access") and hasItem("minor-single-access")
end
function spider()
    return hasItem("spider") and hasItem("major-variety-access") and hasItem("minor-single-access")
end

function major_boards()
    return mancala() or dotsandboxes() or yacht() or fourinarow() or hitandblow() or
            ninemensmorris() or hex() or checkers() or hareandhounds() or gomoku() or
            dominoes() or chinesecheckers() or ludo() or backgammon() or renegade() or
            chess() or shogi() or minishogi() or riichi()
end

function major_cards()
    return hanafuda() or lastcard() or blackjack() or holdem() or president() or
            sevens() or speed() or matching() or war() or takoyaki() or
            pigstail()
end

function major_sports()
    return golf() or billiards() or bowling() or darts() or tennis() or
            soccer() or curling() or boxing() or baseball() or hockey()
end

function major_variety()
    return carrom() or slotcars() or fishing() or battletanks() or teamtanks() or
            shootinggallery() or sixballpuzzle() or slidingpuzzle() or mahjong() or klondike() or
            spider()
end

function minor_wooden()
    return mancala() or yacht() or ninemensmorris() or checkers() or hareandhounds() or
            chinesecheckers() or backgammon() or chess()
end

function minor_paper()
    return dotsandboxes() or fourinarow() or hitandblow() or hex() or dominoes() or
            ludo() or renegade()
end

function minor_jp()
    return gomoku() or shogi() or minishogi() or hanafuda() or riichi() or
            takoyaki() or pigstail()
end

function minor_non_jp()
    return lastcard() or blackjack() or holdem() or president() or sevens() or
            speed() or matching() or war()
end

function minor_sophisticated()
    return golf() or billiards() or bowling() or darts() or hockey()
end

function minor_toy()
    return tennis() or soccer() or curling() or boxing() or baseball()
end

function minor_variety()
    return carrom() or slotcars() or fishing() or battletanks() or teamtanks() or
            shootinggallery() or sixballpuzzle()
end

function minor_single()
    return slidingpuzzle() or mahjong() or klondike() or spider()
end