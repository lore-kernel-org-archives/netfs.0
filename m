Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBC1CBE9C
	for <netfs@lists.linux.dev>; Wed,  2 Oct 2024 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861607; cv=none; b=Tic+sFuZWPuJE3Hz0pvWqkDGFfrVMtQJSfMQoUMpn9pW2zsQnLa6S61SpRKhNEvEemPNVuo5rn0pPCGZEmol0Z4O5WqDbNBPSVdtyikp/b2AixsUqiqNhAz1HtbuYU6HxzfZ2gFconHDIeoXqcRBBlwoQXlrqC5vGYH64g4RkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861607; c=relaxed/simple;
	bh=1EP1SXtR8GMY60GTFp6YWsMa8oFAibWNIly5Yyoh2ck=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cXfctPQU0FBR5PdPYVgTKlkegC1MOUldnHGKLhwDvsWK3HJNDBlAtupKj5NbdKsDF3hknlSHA4fszSSXWaSNB65Rpc7rrZy6B7G/2lRxKmCvr2qtHm8X7ObsuSw1bmmsjRjeRzdeuQj/J7oDMEoH57YbUGUR51UjpMDIGwdbMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=getgoogleoff.me; spf=pass smtp.mailfrom=getgoogleoff.me; dkim=pass (2048-bit key) header.d=getgoogleoff.me header.i=@getgoogleoff.me header.b=Hlfb/brV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=getgoogleoff.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getgoogleoff.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getgoogleoff.me header.i=@getgoogleoff.me header.b="Hlfb/brV"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 0780823CB8
	for <netfs@lists.linux.dev>; Wed,  2 Oct 2024 11:33:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PIrTC_I7Azg2 for <netfs@lists.linux.dev>;
 Wed,  2 Oct 2024 11:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=getgoogleoff.me;
	s=mail; t=1727861588;
	bh=1EP1SXtR8GMY60GTFp6YWsMa8oFAibWNIly5Yyoh2ck=;
	h=Date:To:From:Subject;
	b=Hlfb/brVBp1TH8ilr5svL0XoWrvnnAbZVMX60ILPyvD1OKsW0eAk0V2KbmSrSz8Fn
	 SrOZB2TAMfJMuAbnHkBQk1RWwrfSS/9DOKb18QkFNh/8aMZOH5JXWA4gtWjTUUqF4c
	 ZPFut+StERXdFzz/ZX4Bdr00rO150Zl6BlyLfPwlIKHSnmplWc7Qdg1usB/a2HbFIR
	 yPyux9+M6e+TKRuIX+DI7425UuY4tlaF2BL8Z20w6ASSu3ej1/tr+Iies4BpP7W96H
	 v6htuLOTxvmaUxcpJoX9HJ6I760tQ0yl6zUEVPEUhCr5WExAte+y/b/Zs7fDELymSY
	 KGUK8ncCOsLFA==
Message-ID: <6265b94c-af8a-45df-b81d-c3957d5d75a9@getgoogleoff.me>
Date: Wed, 2 Oct 2024 17:31:45 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Language: en-US
To: netfs@lists.linux.dev
From: exxxxkc <exxxxkc@getgoogleoff.me>
Subject: Re:[PATCH] netfs: Fix the netfs_folio tracepoint to handle NULL
 mapping
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi sry i misstakenly sended the patch to the maililst.

