
import { GoogleGenAI } from "@google/genai";

const ai = new GoogleGenAI({ apiKey: process.env.API_KEY || '' });

export const translateToIzon = async (text: string) => {
  try {
    const response = await ai.models.generateContent({
      model: 'gemini-3-flash-preview',
      contents: `Translate the following English text into the Amassoma dialect of the Izon (Ijaw) language. 
      Please provide the translation, a phonetic pronunciation guide, and a brief explanation if there are cultural nuances.
      English Text: "${text}"`,
      config: {
        systemInstruction: "You are an expert linguist specializing in the Izon language, specifically the Amassoma dialect from Southern Ijaw, Bayelsa State, Nigeria. You help people learn and communicate in their native tongue accurately.",
        temperature: 0.3,
      }
    });
    return response.text;
  } catch (error) {
    console.error("Translation Error:", error);
    return "I'm sorry, I couldn't process that translation at the moment. Please try again later.";
  }
};

export const getHistoryInsight = async (topic: string) => {
  try {
    const response = await ai.models.generateContent({
      model: 'gemini-3-flash-preview',
      contents: `Provide a detailed historical or cultural insight about Amassoma, Southern Ijaw regarding: ${topic}. Include information about its importance to the Ijaw people.`,
      config: {
        systemInstruction: "You are a historian specializing in the Niger Delta and the Ijaw (Izon) ethnic group. You have deep knowledge of Amassoma history, including the founding, the role of Niger Delta University, and local traditions.",
      }
    });
    return response.text;
  } catch (error) {
    console.error("History Error:", error);
    return "History is a deep river; currently, the currents are too strong. Try another topic.";
  }
};
