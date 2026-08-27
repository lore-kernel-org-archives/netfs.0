Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369B3B8130
	for <netfs@lists.linux.dev>; Thu, 27 Aug 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817944; cv=none; b=qbGc+jDI/9Gy486XelTkzKeKJGAtmrL+mJsfLlEg2nCJV1paP/2YFIzVkLgSndY+cYStx4HcbZKq88zHvdAg9nU0tzoJ80rEGRt7aWN9GnZhykBzxFZpJyCnfnHEFaH1VI6A/XKdQqVp5qsHjm9Pgp9dVGuE7CQANnesncjxxpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817944; c=relaxed/simple;
	bh=9CVWleTaSrdVhxxRUhw4ZUJyn3Jg9XY0R1skItqGr00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djC4IX4U3VvimQAqwdYslPextCIYN5/+63ylZwMh9XPYMQpGqA7BnrZQ4nXA1si9kzecNBreMUH9pCaAWvA1BRh3BJtGpZKk+TS4gCtgzK0p9uDb7TKy097D0e/pEFHx3DaVswXfg5b51kPVerE7Rh3j9XkMyI78XLFiJE49aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n+NVd3oQ; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="n+NVd3oQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787817928;
	bh=QoH1s/dQqMRnerLRulBMAWipEN11a7O5ilwtRmrJkUc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=n+NVd3oQvZOwC8G3DpOMhkkwycbp4CFzffgq/6jMZjZXvo5C1xGurOMe3IlbLBmPP
	 yG3Ds1ou4UaxCnD4fMIXDjTBc35qXt9PWEYw7cIJ0Q7s+XYZn0zn6a2x7p6fxcnscI
	 FAhDmwXBkmqAJ6dRmoHWG84F1nO7xOJVhELU3amw=
X-QQ-mid: zesmtpgz5t1787817922te8c9b670
X-QQ-Originating-IP: mOk7kULihjnbT2BpzspnOIplwfDxYHLmryj7MxW7dqU=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 16:05:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11851014657286288873
From: Yichong Chen <chenyichong@uniontech.com>
To: dhowells@redhat.com
Cc: netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: fix out-of-bounds read in coherency trace
Date: Thu, 27 Aug 2026 16:05:20 +0800
Message-Id: <20260827080520.2410207-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1924988.1787815878@warthog.procyon.org.uk>
References: <1924988.1787815878@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: METBPFwEUDZ+UD7wuFRW848CLi3z1KE5VwH+3z1cLr+sdd1MLKsmeRSf
	jsg7pG+94fGF0g9KuWADsaUfsYAwlja77dtBP9wjKvSlPu+VP0G/7gstdZr+tE8okNsGvDt
	7ghUpKFoZj1aXCCkJGlGPOnjxkoSskIabr2shJh5v3d9tszLP84RIQj9M+FC82Vsn7rujoG
	PbdR3eSYM7puZr+TU9dV0TYQI2yAB3puFfWJcvqZ1bLNPg4180o/AeCMxYBpW/WjUSotZMT
	3ux6ISTlP66lKlWcGdUxcIx2LTqR3YjSVYElNgO90Gf2sNue2zZRwZoq44Z3uEuHIW8L1aN
	e9N9aXSzdPJO1Tc+vR+CTzIsAfPgSry2c64vqRdE9FuUQCTQNZ9gmjsOfvMz2kjfOhjMdW9
	W/P29whPCUWonxfnOw8iEvV4nFOMZKFIJ+2720LKLTeNBe9bxBHk0/24tJ5PEUd5GdhJDSd
	j3iBc3o98WMD6aL5z1Gl7+5usM+0E1vB4bIOiYsRIqqrqYn+Ru0kEk1xJQNM9bzZLFWZkq+
	MZRN/4Pf0xNhQ2aHD+TeVl5O7H6KwB5Cp/LDSwaNqMbGmsJaBPTnSoiK5M28j7C9gbsRV2f
	TCMV/5wgllUvXMse0PnsGbRTSKtVIgW3zYunHLp3bLORPICh3+KPmXM1Krk+kst3C+Y0E2G
	ZIphXnTrQYj2QDwz+5IgDMgMWlzCuSTxbvBy5iVNh3s+DfCZln9tM+tZX78Akzo4yTvymxU
	OpV04LxNeJQHvzI9u4XXQf/itGeTCsKVYDw9fiCIy0A5hWzrLnMP5tEUBi0g+MQ8vcaIuDN
	BSGtpbyETxxFnPa5SeHYElxsL/uqoGHbGNP8W3+Wlcc60ITJCTVAmuuW+SioWl1YiF0UJ7k
	w8TBtjrqZK8mNTvNCTO7njYY9rmhKmyH4lEqv1WiQgEvUnc9BZ1OB7/GKgjB3yXdNoHovTi
	xu5ZNWeDaEw0ESMSwVmJPj5lQvWMjhaWpjyzzaVaJVsoT7U1zrCDQFSeb5dTXzoX2e1cJSD
	NCvLCtIg+jqLNMi8rI6gFch0amW/j1Pu8v0bFsuXqTTXBSw7BktnDy1/4kswtp1KWVoUYJp
	aKrs2qrcrom
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

On Thu, Aug 27, 2026 at 08:31:18AM +0100, David Howells wrote:
> Thanks, but I have a patch for this.  See patch 9 here:
>
> https://lore.kernel.org/linux-fsdevel/20260825132045.1000787-1-dhowells@redhat.com/
>
> I don't want to call memcpy() like this just for the purposes of a tracepoint
> that is almost certainly not actually be active.
>
> You're also moving buf->content into a variable rather than using it directly
> - is there a reason for that?

Thanks for pointing me to your patch.

The local content variable was intended to avoid reading fields from the
xattr buffer on the getxattr failure path, where the buffer contents may
not be valid.

Your patch already handles the short auxiliary data case by making room for
the traced bytes and pre-clearing them, so please ignore my patch.  I'll
drop it on my side.

Thanks,
Yichong
