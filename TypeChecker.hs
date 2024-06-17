module TypeChecker where 

import Lexer

import Debug.Trace

type Ctx = [(String, Ty)]

typeof :: Ctx -> Expr -> Maybe Ty
typeof ctx e = let result = case e of
                    BTrue -> Just TBool
                    BFalse -> Just TBool
                    (Num _) -> Just TNum
                    (Add e1 e2) -> case (typeof ctx e1, typeof ctx e2) of 
                                     (Just TNum, Just TNum) -> Just TNum
                                     _                      -> Nothing 
                    (And e1 e2) -> case (typeof ctx e1, typeof ctx e2) of 
                                     (Just TBool, Just TBool) -> Just TBool 
                                     _                       -> Nothing
                    (If e e1 e2) -> 
                        case typeof ctx e of 
                          Just TBool -> case (typeof ctx e1, typeof ctx e2) of 
                                          (Just t1, Just t2) -> if t1 == t2 then
                                                                  Just t1 
                                                                else 
                                                                  Nothing
                                          _                  -> Nothing 
                          _          -> Nothing
                    (Var v) -> lookup v ctx 
                    (Lam v t1 b) -> let Just t2 = typeof ((v, t1):ctx) b 
                                     in Just (TFun t1 t2)
                    (App t1 t2) -> case (typeof ctx t1, typeof ctx t2) of 
                                     (Just (TFun t11 t12), Just t2) -> if t11 == t2 then 
                                                                         Just t12 
                                                                       else 
                                                                         Nothing
                                     _                              -> Nothing 
                    (Eq e1 e2) -> case (typeof ctx e1, typeof ctx e2) of 
                                    (Just t1, Just t2) -> if t1 == t2 then
                                                            Just TBool
                                                          else 
                                                            Nothing
                                    _                  -> Nothing
                    (Paren e) -> typeof ctx e 
                in case result of
                    Just t  -> trace ("Type of " ++ show e ++ " is " ++ show t) result
                    Nothing -> trace ("Type error in " ++ show e) result

typecheck :: Expr -> Expr 
typecheck e = case typeof [] e of 
                Just _ -> e 
                _      -> error "Type error"