const fetch = require('node-fetch');

exports.handler = async (event, context) => {
    const { placeId, jobId } = event.queryStringParameters;
    
    try {
        // URLs de join avancées
        const joinUrls = {
            primary: `https://www.roblox.com/games/start?placeId=${placeId}&jobId=${jobId}&launch=true`,
            mobile: `https://www.roblox.com/games/start?placeId=${placeId}&jobId=${jobId}&mobile=true`,
            direct: `https://www.roblox.com/games/start?placeId=${placeId}&jobId=${jobId}`,
            protocol: `roblox://placeId=${placeId}&jobId=${jobId}`
        };

        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify({
                success: true,
                message: "Server join links generated",
                links: joinUrls,
                serverInfo: {
                    placeId: placeId,
                    jobId: jobId,
                    generatedAt: new Date().toISOString()
                }
            })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({
                success: false,
                error: error.message
            })
        };
    }
};