module PyLex where

import Text.Parsec

data PyToken = PyName String
             | PyInteger Int
             | PyFloat Double
             | PyImport
               deriving Show

type PyTokenParser = Parsec String () PyToken

parseKeyword :: PyTokenParser
parseKeyword = do
  kw <- many1 letter
  notFollowedBy letter
  case kw of
    "import" -> return PyImport
    _        -> fail "Unknown keyword"

parseName :: PyTokenParser
parseName = do
  fc <- (letter <|> char '_')
  rest <- many1 (alphaNum <|> char '_')
  return $ PyName (fc:rest)

parseToken :: PyTokenParser
parseToken = try parseName <|> try parseName

lexTokens sourceCode = case parse parseToken "python-lex" sourceCode of
                          Left  err -> error ("Error: " ++ show err)
                          Right val -> val

c1 = "import"
c2 = "import sys"
c3 = "importsys"
