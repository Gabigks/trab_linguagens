module Main where

import Lexer
import Parser
import TypeChecker
import Interpreter
import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [fileName] -> do
      content <- readFile fileName
      print content
      let tokens = lexer content
      putStrLn "Tokens:"
      print tokens
      let ast = parser tokens
      putStrLn "\nAST:"
      print ast
      let checkedAst = typecheck ast
      putStrLn "\nType Checked AST:"
      print checkedAst
      let evaluatedResult = eval checkedAst
      putStrLn "\nEvaluated Result:"
      print evaluatedResult
      let jsCode = toJavaScript checkedAst
      putStrLn "\nJavaScript Code:"
      putStrLn jsCode
    _ -> putStrLn "Usage: program <filename>"
