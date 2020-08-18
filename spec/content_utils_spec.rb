require "rails_helper"

require "content_utils"

RSpec.describe ContentUtils do
  describe ".extract_year" do
    {
      "is a 1975 album" => "1975",
      "First released in 1968 on Verve Records" => "1968",
      "originally released in 1967" => "1967",
      "released by Elektra Records on March 3, 1986" => "1986",
      "released by Island Records in February 1995" => "1995",
      "released as a double album in March 1987" => "1987",
      "released August 10, 1979 on Epic Records" => "1979",
      "released in June of 1995" => "1995",
      "released in 30 May 1981" => "1981",
      "released in 1975 by Columbia Records" => "1975",
      "released in November 1985 on Blanco y Negro Records" => "1985",
      "released in the United States on October 10, 1966" => "1966",
      "released on 13 April 1973" => "1973",
      "released on November 30th, 1979" => "1979",
      "released on Warner Bros. Records on 28 February 1970" => "1970",
      "Released by Polydor in 1991 as a single-disc alternative to the Star Time box set" => "1991",
      "Released by Capitol Records in 1987." => "1987",
      "released by Epic/CBS Records on June 30, 1973" => "1973",
      "released worldwide February 13, 1996" => "1996",
      "the album was released in July 1971" => "1971",
      "The soundtrack was released on November 15, 1977" => "1977"
    }.each do |phrase, year|
      it "expects #{phrase.inspect} to contain #{year}" do
        expect(described_class.extract_year(phrase)).to eq year
      end
    end
  end
end
