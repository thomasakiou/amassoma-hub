
import React, { useState } from 'react';
import { translateToIzon } from '../services/geminiService';
import { ICONS } from '../constants';

const Translator: React.FC = () => {
  const [inputText, setInputText] = useState('');
  const [result, setResult] = useState('');
  const [loading, setLoading] = useState(false);

  const handleTranslate = async () => {
    if (!inputText.trim()) return;
    setLoading(true);
    const translation = await translateToIzon(inputText);
    setResult(translation || 'Translation failed.');
    setLoading(false);
  };

  return (
    <div className="bg-white rounded-2xl shadow-sm p-6 border border-slate-200">
      <h2 className="text-2xl font-bold mb-4 flex items-center gap-2">
        <ICONS.Language />
        Izon (Amassoma) Translator
      </h2>
      <p className="text-slate-600 mb-6">Connect with your roots. Translate phrases into the local dialect.</p>
      
      <div className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-slate-700 mb-1">English Phrase</label>
          <textarea
            className="w-full p-4 rounded-xl border border-slate-200 focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all outline-none min-h-[100px]"
            placeholder="Type something in English..."
            value={inputText}
            onChange={(e) => setInputText(e.target.value)}
          />
        </div>

        <button
          onClick={handleTranslate}
          disabled={loading || !inputText}
          className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-6 rounded-xl transition-colors disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
        >
          {loading ? (
            <div className="animate-spin rounded-full h-5 w-5 border-2 border-white border-t-transparent" />
          ) : (
            <>Translate <ICONS.Send /></>
          )}
        </button>

        {result && (
          <div className="mt-6 p-6 bg-slate-50 rounded-xl border border-blue-100">
            <h3 className="font-semibold text-blue-900 mb-2">Translation & Insights:</h3>
            <div className="prose prose-slate max-w-none text-slate-700 whitespace-pre-wrap">
              {result}
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default Translator;
