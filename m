Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58216A936
	for <netfs@lists.linux.dev>; Sat,  1 Mar 2025 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838649; cv=none; b=J2EeWdJm6bkCMabI6CF0Kl9HG9Xtm0hwyM+tqJta8YHes7RZTK3WV2ZI0sZZTG7W+PCLp8MAoSr950Ign+r6mDksq69iQVjYVMo3kxXZvqqKTghFWs0IoXBgj9Tgf2XA+fZkhuZX0toPej2b8jd2hjMMmg1qX8/sSBEwhK/s6gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838649; c=relaxed/simple;
	bh=/DF2JoumYBYqsnFTIdin6swrkcPaU5ofu3NC6lS6/zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPS4K1ZXxM/ZvzN+eRNnXnREiLL46AByyNzfQUVatfXjyU/P9MIE4eQMeCRspKq+ZbPSNn+1Z9J3yG3WGmFpmRnrBp5xvXsVnhG2hFnfPVpeLEXTd5SoEsH/73yryuf6Pw8SSWKVoUbBs5SHwtKbSDOIVt1or2B8kJUVpHkEnf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2CrHz66; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2CrHz66"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43996e95114so20865625e9.3
        for <netfs@lists.linux.dev>; Sat, 01 Mar 2025 06:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740838645; x=1741443445; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PahHoOir8qfv1LTrsi6925KzDdTFMUlnOTruGGEqzcE=;
        b=f2CrHz66wnm+zHJiGOG5odYAewTTbbpmRWS+0uKkCDFhe1NHysd683hjc0dDHtvuRk
         cGFcJXNf0q6dX3/jGorr5qxTQEr190ablWcJCZ5yAmG/HjAltzkvrc6Vt8sor5bkK5+D
         EIRJwYks2KdBiGn5tIw3DB9LUjiI+jgcgSD/3qdB5nPacuFg8aFkNJbGtnpGXR5RrJ/j
         13d985afxJAwxYVU1oWKYe2QYFKpQ4RuIUkB1siLePhzpXPiJ8agKYy1bId5AGNYF9yR
         GMck+tq0s4ReBAk2EFck45u90cTFwt2LEYFIYi6w5DjqZS1GgdeEe28Yv+H+upR6Qtb1
         SOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838645; x=1741443445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PahHoOir8qfv1LTrsi6925KzDdTFMUlnOTruGGEqzcE=;
        b=vvUCMM4A47+KWYjVPRgOUxMKKDdm5BZC9S9aJ3RYSmuxTQ2IqW3JDCKjg28OBX0UzJ
         iozrTzXyvnwPPatlF9moIOsT7jD2kVh1fe2+UqbXwZC2nCgMg2wP0s4HIUu+EHBuw0qP
         rxrDQuvleOK3TL0kjZn2RI3sHPRScai8JcTlm59agPjzFmQaR1xlKqYaRGZGE5LlpCgo
         mi5qKJROfZGb5ml2i5eEoV/Sy8TElFfwhVDq0vQCfCubK9ofX/BMxDcOxuVBCnGKghYQ
         Tz3/99ZKT5ctdxjYt87V5PVIG6zchrWGVfDGAC5+Nzee5N/t1Es7iLYupv7SMasKJXL+
         ikIg==
X-Forwarded-Encrypted: i=1; AJvYcCUK9wKUE3R393krlGMI+sT7qOeKJAglecl3/nyl2OB6pMtlG3A9UKIzvWFyFZx0j+n/EKhx5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiSsrKNqnaM5xdUFiN16vrBJeVMxKNv5IMXcUX8Edm210cewdQ
	k0xg/XUxCTlFy6a2pAcVji3kyN15hXjWkEz5BFM2d4j62zpkobfE
X-Gm-Gg: ASbGncusmmkIFnz+yIE5Pl/Ocsvaoi6httSy4/8ijPJlrCjFPrKGc8iFgd6jhLqYFpV
	Beb3cE8OXqYYDhR7mwmLEthTibo2Dl5nO+tSETu+KzB/Cjw4T3b4gycWhGouszu3aEM8qASTcIS
	rryFioQwoemHyB7EifCby97yJ3tsC4JoafVDgs8tKWownMLMM6/hXHfC1hXO3FYSdOdHj+lfT90
	vgdfvSmtsnzWQKFpe1rC9lE8xMyS9XZ4+wnnVrbMsphk1g0MvnZvXz6QNpeL4FebGgO7Up6rbC6
	rmogoN3Lt5QhAZ9DC7Wvr6V1BnqwvQIf6p7mmZA3t4TT7JlF616QL6pabtD+uE3lXmDlc/VQL4p
	YFw==
X-Google-Smtp-Source: AGHT+IHu+uW89Mv4jA7RdnRSpYtxvOY2+1IkdU5Ipoc2fSlHUuZeY5k321zzQexeQH1iEHNQ0xrsAg==
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr54184245e9.21.1740838645395;
        Sat, 01 Mar 2025 06:17:25 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba53945bsm124253195e9.23.2025.03.01.06.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:17:24 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id C2D63BE2DE0; Sat, 01 Mar 2025 15:17:23 +0100 (CET)
Date: Sat, 1 Mar 2025 15:17:23 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] fs/netfs/read_collect: add to next->prev_donated
Message-ID: <Z8MW86zYK3VEPcHF@eldamar.lan>
References: <CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com>
 <20250210191118.3444416-1-max.kellermann@ionos.com>
 <3978045.1739537266@warthog.procyon.org.uk>
 <CAKPOu+8cD=HkoNYYknivDJnb6Pfxv+KF28SBUDEqha4NE5sxhg@mail.gmail.com>
 <2025022051-rockband-hydroxide-7471@gregkh>
 <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_WsE_HZ_u_sbP8aPnCXknU51fM9t_L-g+xmNVwWGDHVg@mail.gmail.com>

Hi

(btw side question from a bystander looking a the bug)

On Thu, Feb 20, 2025 at 04:00:49PM +0100, Max Kellermann wrote:
> On Thu, Feb 20, 2025 at 3:17 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > It wasn't sent to me or to the stable list, so how could have I seen it?
> 
> Oh, of course, I forgot to add stable. How shall we proceed? Do you
> want me to resend to you with David's Signed-off-by?

Do I see it correctly that this will be 6.12.y and 6.13.y specific
backports since the code in mainline changed substantially with
e2d46f2ec332 ("netfs: Change the read result collector to only use one
work item") and so your change does not apply there anymore?

I'm asking since we got a bug report in Debian which seems to idicate
it might have the same root cause as you report, and it is at
https://bugs.debian.org/1098698 .

Regards,
Salvatore
