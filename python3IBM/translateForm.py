from watson_developer_cloud import LanguageTranslatorV2

def main(args):
    customer_id = args["customer_id"]
    text = args["payload"]
    language_translator = LanguageTranslatorV2(
        url=args["__bx_creds"]["language_translator"]["url"],
        username=args["__bx_creds"]["language_translator"]["username"],
        password=args["__bx_creds"]["language_translator"]["password"])
    lang_id = language_translator.identify(text)["languages"][0]["language"]
    response = language_translator.translate(text, source=lang_id, target='en')
    return {"payload": response["translations"][0]["translation"],
            "customer_id": customer_id}
