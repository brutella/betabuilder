module BetaBuilder
  module DeploymentStrategies
    class Appcast < Strategy
      include "testflight" 
      def extended_configuration_for_strategy
        proc do
          def deployment_url
            File.join(deploy_to, target.downcase, ipa_name)
          end

          def manifest_url
            File.join(deploy_to, target.downcase, "manifest.plist")
          end

          def remote_installation_path
            File.join(remote_directory, target.downcase)
          end
        end
      end
      
      def prepare
        File.open("pkg/dist/sparkle.xml", "w") do |io|
          io << %{
            <?xml version="1.0" encoding="utf-8"?>
            <rss version="2.0" xmlns:sparkle="http://www.andymatuschak.org/xml-namespaces/sparkle"  xmlns:dc="http://purl.org/dc/elements/1.1/">
               <channel>
                  <title>Changelog</title>
                  <description>Changelog</description>
                  <language>en</language>       
                     <item>
                        <title>Beta</title>
            						<sparkle:releaseNotesLink>
            						</sparkle:releaseNotesLink>
                        <pubDate>Wed, 22 Feb 2012 21:00:00 +0000</pubDate>
                        <enclosure url="" sparkle:version="1636" length="2848" type="application/octet-stream" sparkle:dsaSignature="MC0CFQDfLbPWQQ1TkjaKTUkBiYQOnY0cbAIUBz/E1d1zM4E3d2K7j8Lo3cV8nQs="/>
                     </item>
               </channel>
            </rss>
          }
        end
      end
      
      def deploy
        
      end
    end
  end
end
